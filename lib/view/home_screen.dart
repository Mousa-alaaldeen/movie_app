// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unnecessary_import, unnecessary_brace_in_string_interps, unused_label, dead_code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mov/controller/search_controller.dart';
import 'package:mov/util/constants.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:mov/view/search_screen.dart';
import 'package:mov/widget/MovieListWidget.dart';
import 'package:mov/widget/custom_carousel_slider.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: IconButton(
              onPressed: () {
                Get.to(() => const SearchScreen(), binding: SearchBinding());
              },
              icon: Icon(Icons.search)),
        ),
        body: GetBuilder<HomeController>(builder: (_) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text("TV",
                      style: TextStyle(
                        color: kRedColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                CustomCarouselSlider(),
                MovieListWidget(
                  text1: 'N',
                  text2: 'ow playing',
                  list: controller.nowPlayingList,
                ),
                MovieListWidget(
                  text1: 'U',
                  text2: 'pcoming Movie',
                  list: controller.upcomingList,
                ),
                // SizedBox(
                //   height: 220,
                //   child: MovieCard(),
                // ),
                MovieListWidget(
                  text1: 'P',
                  text2: 'opular',
                  list: controller.list,
                ),
              ],
            ),
          );
        }));
  }
}
