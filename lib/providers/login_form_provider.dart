import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    // ignore: avoid_print
    print(formkey.currentState?.validate());
    // ignore: avoid_print
    print('$email -$password');
    return formkey.currentState?.validate() ?? false;
  }
}
