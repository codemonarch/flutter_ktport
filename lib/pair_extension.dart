class KFPair<T, U> {
    KFPair(this.left, this.right);

    final T left;
    final U right;
    String toString() => 'Pair[$left, $right]';
}
