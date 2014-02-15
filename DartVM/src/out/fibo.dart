int fibo(int n) {
  if (n < 2) {
    return n;
  } else {
    return fibo(n - 1) + fibo(n - 2);
  }
}

main() {
  fibo(40);
}

$ dart fibo.dart
102334155
ret = 903 ms

