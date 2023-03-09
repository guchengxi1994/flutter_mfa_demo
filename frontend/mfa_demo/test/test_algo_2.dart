// ignore_for_file: avoid_print

import 'package:mfa_demo/random_code_mfa/algorithm.dart';

void main() async {
  final r = Algorithm.generate("xiaoshuyui");
  print(r);
}
