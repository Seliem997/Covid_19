import 'package:flutter/cupertino.dart';

class Symptom extends ChangeNotifier {
  final String name;
  bool _isSelected = false;

  Symptom({@required this.name});

  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  get isSelected => _isSelected;
}
