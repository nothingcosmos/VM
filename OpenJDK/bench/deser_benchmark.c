#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <fcntl.h>

#include <stdint.h>
#include <stdbool.h>
#include <arpa/inet.h>

#if defined(__BIG_ENDIAN__) || (defined(__BYTE_ORDER) && __BYTE_ORDER == __BIG_ENDIAN)
#  error architecture must be little endian
#endif

#if defined(_byteswap_uint64) || (defined(_MSC_VER) && _MSC_VER >= 1400)
#  define _ntohll(x) (_byteswap_uint64(x))
#elif defined(bswap_64)
#  define _ntohll(x) bswap_64(x)
#elif defined(__DARWIN_OSSwapInt64)
#  define _ntohll(x) __DARWIN_OSSwapInt64(x)
#else
#  warn _ntohll by bitshift
#  define _ntohll(x) \
      ( ((((uint64_t)x) << 56)                         ) | \
        ((((uint64_t)x) << 40) & 0x00ff000000000000ULL ) | \
        ((((uint64_t)x) << 24) & 0x0000ff0000000000ULL ) | \
        ((((uint64_t)x) <<  8) & 0x000000ff00000000ULL ) | \
        ((((uint64_t)x) >>  8) & 0x00000000ff000000ULL ) | \
        ((((uint64_t)x) >> 24) & 0x0000000000ff0000ULL ) | \
        ((((uint64_t)x) >> 40) & 0x000000000000ff00ULL ) | \
        ((((uint64_t)x) >> 56)                         ) )
#endif

#define _load32(dst, src, type) \
        do { \
            memcpy((type*) (dst), (src), sizeof(type)); \
            *(dst) = ntohl(*(dst)); \
        } while (0);

#define _load64(dst, src, type) \
        do { \
            memcpy((type*) (dst), (src), sizeof(type)); \
            *(dst) = _ntohll(*(dst)); \
        } while (0);

#define _shift32(dst, src, type) (*(dst) = (type) ( \
        (((uint32_t)((uint8_t*)(src))[0]) << 24) | \
        (((uint32_t)((uint8_t*)(src))[1]) << 16) | \
        (((uint32_t)((uint8_t*)(src))[2]) <<  8) | \
        (((uint32_t)((uint8_t*)(src))[3])      ) ))

#define _shift64(dst, src, type) (*(dst) = (type) ( \
        (((uint64_t)((uint8_t*)(src))[0]) << 56) | \
        (((uint64_t)((uint8_t*)(src))[1]) << 48) | \
        (((uint64_t)((uint8_t*)(src))[2]) << 40) | \
        (((uint64_t)((uint8_t*)(src))[3]) << 32) | \
        (((uint64_t)((uint8_t*)(src))[4]) << 24) | \
        (((uint64_t)((uint8_t*)(src))[5]) << 16) | \
        (((uint64_t)((uint8_t*)(src))[6]) << 8)  | \
        (((uint64_t)((uint8_t*)(src))[7])     )  ))

#define FILE_PATH "random.data"

static volatile int32_t v32;
static volatile int64_t v64;

static void run_shift(const char* data, size_t size)
{
    const size_t last = size - 9;
    for(size_t i=0; i < last; i++) {
        char b = data[i];
        i++;
        if(b < 0) {
            _shift32(&v32, data + i, int32_t);
            i += 4;
        } else {
            _shift64(&v64, data + i, int64_t);
            i += 8;
        }
    }
}

static void run_load(const char* data, size_t size)
{
    const size_t last = size - 9;
    for(size_t i=0; i < last; i++) {
        char b = data[i];
        i++;
        if(b < 0) {
            _load32(&v32, data + i, int32_t);
            i += 4;
        } else {
            _load64(&v64, data + i, int64_t);
            i += 8;
        }
    }
}

static void show_measured(const char* name,
        size_t size, int loop,
        const struct timeval* start, const struct timeval* finish)
{
    double time =
        (finish->tv_sec - start->tv_sec) * 1000.0 +
        (finish->tv_usec - start->tv_usec) / 1000.0;
    double msec = time / loop;
    double mbs = size * loop / (time / 1000) / 1024 / 1024;

    printf("-- %s\n", name);
    printf("  %.2f msec/loop\n", msec);
    printf("  %.2f MB/s\n", mbs);

}

int main(void)
{
    const int loop = LOOP;  // compile with -DLOOP=N option

    int fd = open(FILE_PATH, O_RDONLY);

    struct stat stbuf;
    fstat(fd, &stbuf);
    size_t size = stbuf.st_size;

    char* map = mmap(NULL, size, PROT_READ,
            MAP_SHARED, fd, 0);

    printf("size: %lu\n", size);
    printf("loop: %u times\n", loop);

    {
        // warm-up
        for(int i=0; i < loop; i++) {
            run_load(map, size);
        }

        struct timeval start;
        gettimeofday(&start, NULL);

        for(int i=0; i < loop; i++) {
            run_load(map, size);
        }

        struct timeval finish;
        gettimeofday(&finish, NULL);

        show_measured("C load", size, loop, &start, &finish);
    }

    {
        // warm-up
        for(int i=0; i < loop; i++) {
            run_shift(map, size);
        }

        struct timeval start;
        gettimeofday(&start, NULL);

        for(int i=0; i < loop; i++) {
            run_shift(map, size);
        }

        struct timeval finish;
        gettimeofday(&finish, NULL);

        show_measured("C shift", size, loop, &start, &finish);
    }

    munmap(map, size);
}
