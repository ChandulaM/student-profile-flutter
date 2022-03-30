import 'package:flutter/material.dart';

InputDecoration textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    hintStyle: TextStyle(
      color: Colors.grey[500],
    ),
    contentPadding: const EdgeInsets.all(10.0));
