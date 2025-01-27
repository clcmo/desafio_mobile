import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  Future errorDialog(BuildContext context, e) => showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('Error'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 100.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Center(child: Text(e.message.toString())),
            ),
            SizedBox(
                height: 50.0,
                child: Row(children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'))
                ]))
          ])));
}
