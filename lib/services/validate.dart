import 'package:challenge/error_handler.dart';
import 'package:challenge/services/auth_services.dart';
import 'package:flutter/material.dart';

class Validate {
  bool checkFields(formKey) {
    final form = formKey.currentState;
    if (form?.validate() != null) {
      form?.save();
      return true;
    }
    return false;
  }

  String? validateEmail(String value) {
    if (value.isNotEmpty) {
      final RegExp regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      return !regex.hasMatch(value) ? 'Insira um e-mail válido' : null;
    } else {
      return 'Insira um e-mail válido';
    }
  }

  void verifyFields(context, formKey, email, password) {
    if (Validate().checkFields(formKey)) {
      AuthService()
          .signUp(email, password)
          .then((userCredentials) => Navigator.of(context).pop())
          .catchError((e) => ErrorHandler().errorDialog(context, e));
    }
  }

  void verifyFieldsToLogin(context, formKey, email, password) {
    if (Validate().checkFields(formKey)) {
      AuthService()
          .login(email, password, context)
          .then((userCredentials) => Navigator.of(context).pop())
          .catchError((e) => ErrorHandler().errorDialog(context, e));
    }
  }
}
