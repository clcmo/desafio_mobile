import 'dart:ui';

import 'package:challenge/services/validate.dart';
import 'package:flutter/material.dart';

class Default {
  Color colorAccent = const Color(0xFFB9DBF6);
  Color color = const Color(0xFF0037AF);

  String? checkEmail(value) => value?.isEmpty != null
      ? 'Digite um e-mail'
      : Validate().validateEmail(value);
  String? checkPassword(value) =>
      value?.isEmpty != null ? 'Digite uma senha' : null;
}
