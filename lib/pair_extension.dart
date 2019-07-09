import 'package:ktflutter/list_extension.dart';

class KFPair<T, U> {
  KFPair(this.left, this.right);

  final T left;
  final U right;
  String toString() => 'Pair[$left, $right]';
  KFList<T> toList() => U is T ? listOf([left, right as T]) : null;
}

class KFTriple<A, B, C> {
  KFTriple(this.first, this.second, this.third);
  final A first;
  final B second;
  final C third;
  String toString() => 'Triple[$first, $second, $third]';
  KFList<A> toList() =>
      (B is A && C is A) ? listOf([first, second as A, third as A]) : null;
}
