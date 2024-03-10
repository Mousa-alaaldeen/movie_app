// ignore_for_file: prefer_const_constructors
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mov/controller/layout_controller.dart';

class LayoutScreen extends GetView<LayoutControllerr> {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LayoutControllerr>(
        builder: (_) {
          return controller.bottomScreen[controller.carrentIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<LayoutControllerr>(builder: (_) {
        return NavigationBar(
          destinations: controller.bottom,
          selectedIndex: controller.carrentIndex,
          onDestinationSelected: (index) {
            controller.changeBottom(index);
          },
        );
      }),
    );
  }
}
