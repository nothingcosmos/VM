import java.util.Random;

import sun.misc.Unsafe;
import sun.nio.ch.DirectBuffer;
import java.lang.reflect.Field;
import java.nio.ByteBuffer;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class DeserBenchmark {
    public static void main(String[] args) throws Exception {
        if (args.length != 3) {
            System.out.println("usage: <seed> <size> <loop>");
            System.exit(1);
        }
        long seed = Long.parseLong(args[0]);
        int size = Integer.parseInt(args[1]);
        int loop = Integer.parseInt(args[2]);
        new DeserBenchmark().run(seed, size, loop);
    }

    public void run(long seed, int size, int loop) {
        if (seed == 0) {
            seed = new Random().nextInt();
        }

        System.out.printf("seed: %d%n", seed);
        System.out.printf("size: %d bytes%n", size);
        System.out.printf("loop: %d times%n", loop);
        byte[] bytes = new byte[size];
        new Random(seed).nextBytes(bytes);

        ByteBuffer heap = ByteBuffer.wrap(bytes);

        ByteBuffer direct = ByteBuffer.allocateDirect(size);
        direct.put(bytes);

        measure("ByteBuffer heap", size, loop, new ByteBufferRunnable(heap));
        measure("ByteBuffer direct", size, loop, new ByteBufferRunnable(direct));
        measure("Unsafe heap", size, loop, new HeapUnsafeRunnable(bytes));
        measure("Unsafe direct", size, loop, new DirectUnsafeRunnable(direct));

        System.out.println("writing data to random.data file");
        try {
            new FileOutputStream(new File("random.data")).write(bytes);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    private void measure(String name, int size, int loop, Runnable runnable) {
        // warm-up
        for (int i=0; i < loop; i++) {
            runnable.run();
        }

        long startTime = System.currentTimeMillis();

        for (int i=0; i < loop; i++) {
            runnable.run();
        }

        long time = System.currentTimeMillis() - startTime;
        double mbs = size * (long) loop / ((double) time / 1000) / 1024 / 1024;
        double msec = time / (double) loop;

        System.out.printf("-- %s%n", name);
        System.out.printf("  %.2f msec/loop%n", msec);
        System.out.printf("  %.2f MB/s%n", mbs);
    }

    private static class ByteBufferRunnable implements Runnable {
        private ByteBuffer src;

        public int v32;
        public long v64;

        public ByteBufferRunnable(ByteBuffer src) {
            this.src = src;
        }

        public void run() {
            int last = src.limit() - 9;
            for(int i=0; i < last; i++) {
                byte b = src.get(i);
                i++;
                if(b < 0) {
                    v32 = src.getInt(i);
                    i += 4;
                } else {
                    v64 = src.getLong(i);
                    i += 8;
                }
            }
        }
    }

    private static class UnsafeRunnable implements Runnable {
        private static final Unsafe unsafe;

        public int v32;
        public long v64;

        static {
            try {
                Field field = Unsafe.class.getDeclaredField("theUnsafe");
                field.setAccessible(true);
                unsafe = (Unsafe) field.get(null);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        private Object base;
        private long address;
        private int length;

        public UnsafeRunnable(Object base, long address, int length) {
            this.base = base;
            this.length = length;
        }

        public void run() {
            int last = length - 9;
            for(int i=0; i < last; i++) {
                byte b = unsafe.getByte(base, address + i);
                i++;
                if(b < 0) {
                    v32 = unsafe.getInt(base, address + i);
                    i += 4;
                } else {
                    v64 = unsafe.getLong(base, address + i);
                    i += 8;
                }
            }
        }
    }

    private static class HeapUnsafeRunnable extends UnsafeRunnable {
        public HeapUnsafeRunnable(byte[] src) {
            super(src, Unsafe.ARRAY_BYTE_BASE_OFFSET, src.length);
        }
    }

    private static class DirectUnsafeRunnable extends UnsafeRunnable {
        public DirectUnsafeRunnable(ByteBuffer src) {
            super(src, ((DirectBuffer) src).address(), src.limit());
        }
    }
}
