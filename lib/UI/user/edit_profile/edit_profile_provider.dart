import 'package:flutter/material.dart';

class EditProfileProvider<T> extends ChangeNotifier {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController get nameController => this._nameController;

  set nameController(TextEditingController value) {
    this._nameController = value;
    notifyListeners();
  }

  get phoneNumController => this._phoneNumController;

  set phoneNumController(value) {
    this._phoneNumController = value;
    notifyListeners();
  }

  get emailController => this._emailController;

  set emailController(value) {
    this._emailController = value;
    notifyListeners();
  }
}
