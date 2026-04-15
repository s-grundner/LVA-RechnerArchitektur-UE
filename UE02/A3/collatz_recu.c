int collatz(int n) {
  if (n == 1) return 0;
  else if (n%2 == 1) return 1 + collatz(3n + 1);
  else return 1 + collatz(n/2);
}

