
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showMessage(
    {required BuildContext context,
    required VoidCallback onPressOk,
    required String title,
    required String message}) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  Widget okButton = TextButton(onPressed: onPressOk, child: const Text("Ok"));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}