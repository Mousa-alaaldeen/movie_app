// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/controller/home_controller.dart';

class TestScreen extends GetView<HomeController> {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('data'),
            ),
          );
        });
  }
}
