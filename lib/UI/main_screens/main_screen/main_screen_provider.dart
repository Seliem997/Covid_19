import 'package:flutter/cupertino.dart';

class MainScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => this._currentIndex;

  set currentIndex(value) {
    this._currentIndex = value;
    notifyListeners();
  }
}
