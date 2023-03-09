// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';

import 'algorithm.dart';

class AlgoController extends ChangeNotifier {
  late AlgotithmContent? algotithmContent = null;

  init() {
    algotithmContent = Algorithm.generate("xiaoshuyui");
    // debugPrint(algotithmContent!.code);
    notifyListeners();
  }
}
