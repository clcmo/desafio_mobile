import 'dart:ui';

import 'package:challenge/services/validate.dart';
import 'package:flutter/material.dart';

class Default {
  Color colorAccent = const Color(0xFFB9DBF6);
  Color color = const Color(0xFF0037AF);
  Color white = const Color(0xFFFFFFEF);

  String? checkEmail(value) => value?.isEmpty != null
      ? Validate().validateEmail(value)
      : 'Digite um e-mail';

  String? checkPassword(value) =>
      value?.isEmpty != null ? null : 'Digite uma senha';
}
