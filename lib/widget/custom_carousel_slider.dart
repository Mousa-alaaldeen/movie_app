// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:mov/model/model.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

class CustomCarouselSlider extends GetView<HomeController> {
  const CustomCarouselSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      return controller.tVImage.isEmpty
          ? SizedBox(child: CircularProgressIndicator())
          : SizedBox(
              width: Get.width,
              height: (Get.height * 0.33 < 300) ? 300 : Get.height * 0.33,
              child: Stack(
                children: [
                  FanCarouselImageSlider(
                    imageRadius: 30,
                    sliderHeight: 250,
                    imageFitMode: BoxFit.fill,
                    imagesLink: controller.tVImage,
                    showIndicator: false,
                    isAssets: false,
                    isClickable: false,
                  ),
                ],
              ),
            );
    });
  }
}
