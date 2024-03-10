// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "!",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      content: Text("An error occurred while fetching data"),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Ok"),
        ),
      ],
    );
  }
}
