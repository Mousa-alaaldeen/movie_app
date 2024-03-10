// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:mov/util/constants.dart';

class MovieCard extends GetView<HomeController> {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Movie",
            style: kTitleTextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.upcomingList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                        "https://image.tmdb.org/t/p/w500/${controller.upcomingList[index].posterPath}"),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
