import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailSignInProvider extends ChangeNotifier {
  bool _isLoading;
  bool _isLogin;
  String _userEmail;
  String _userPassword;
  String _userName;
  DateTime _dateOfBirth;

  EmailSignInProvider() {
    _isLoading = false;
    _isLogin = true;
    _userEmail = "";
    _userPassword = "";
    _userName = "";
    _dateOfBirth = DateTime.now();
  }

  get isLoading => this._isLoading;

  set isLoading(value) {
    this._isLoading = value;
    notifyListeners();
  }

  get isLogin => this._isLogin;

  set isLogin(value) {
    this._isLogin = value;
    notifyListeners();
  }

  get userEmail => this._userEmail;

  set userEmail(value) {
    this._userEmail = value;
    notifyListeners();
  }

  get userPassword => this._userPassword;

  set userPassword(value) {
    this._userPassword = value;
    notifyListeners();
  }

  get userName => this._userName;

  set userName(value) {
    this._userName = value;
    notifyListeners();
  }

  get dateOfBirth => this._dateOfBirth;

  set dateOfBirth(value) {
    this._dateOfBirth = value;
    notifyListeners();
  }

  Future<bool> login() async {
    try {
      isLoading = true;
      if (isLogin) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
      }
      // this for registeration
      else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
      }
      isLoading = false;
      return true;
    } catch (error) {
      isLoading = false;
      return false;
    }
  }
}
