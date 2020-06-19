import 'package:flutter/material.dart';

class CountModel extends ChangeNotifier {


  int _count=0;


  get count {
    return this._count;
  }

  void increment() {
    this._count++;
    notifyListeners();
  }


}