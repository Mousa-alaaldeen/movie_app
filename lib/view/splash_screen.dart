// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/controller/layout_controller.dart';

import 'package:mov/view/layout_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delay navigation to LayoutScreen
    Future.delayed(Duration(seconds: 2), () {
      Get.off(LayoutScreen(), binding: LayoutBinding());
    });

    return Scaffold(
      body: Center(
        child: FadeInDelayedWidget(
          delay: Duration(seconds: 200),
          child: Text(
            'Welcome to the Movie App',
            style: TextStyle(fontSize: 24, color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class FadeInDelayedWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const FadeInDelayedWidget({
    Key? key,
    required this.child,
    required this.delay,
  }) : super(key: key);

  @override
  _FadeInDelayedWidgetState createState() => _FadeInDelayedWidgetState();
}

class _FadeInDelayedWidgetState extends State<FadeInDelayedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      // Delay animation based on widget's delay property
      reverseDuration: widget.delay,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
