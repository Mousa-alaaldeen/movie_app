// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unnecessary_import, unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:mov/controller/top_rated_controller.dart';
import 'package:mov/util/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mov/util/constants.dart';
import 'package:mov/widget/movie_detail.dart';

class TopRatedScreen extends GetView<TopRatedController> {
  const TopRatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: GetBuilder<TopRatedController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<TopRatedController>(builder: (cont) {
            if (cont.list.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: controller.list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(MovieDetailScreen(
                        
                        voteCount: controller.list[index].voteCount.toString(),
                        movieId: controller.list[index].id!,
                        imageUrl: controller.list[index].backdropPath!,
                        title: controller.list[index].originalTitle!,
                        year: controller.list[index].releaseDate!.toString(),
                        originalTitle: controller.list[index].originalTitle!,
                        overview: controller.list[index].overview!,
                        onRatingUpdate: (rating) {
                          Get.find<HomeController>().setRate(
                              movieId: controller.list[index].id!, val: rating);

                          print('تم تعيين التقييم بنجاح: $rating');
                        },
                        initialRating: controller.list[index].voteAverage!,
                        deleteRate: () async {
                          try {
                            await Get.find<HomeController>().deleteRate(
                              movieId: controller.list[index].id!,
                            );

                            print('تم حذف التقييم بنجاح');
                          } catch (error) {
                            print('حدث خطأ أثناء حذف التقييم: $error');
                          }
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              "${baseUrlImag}${controller.list[index].backdropPath}",
                          height: 120,
                          width: 120,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            controller.list[index].originalTitle.toString(),
                            style: kBoldedSubtitleTextSyule,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 10,
                ),
              );
            } else {
              return Container();
            }
          }),
        );
      }),
    ));
  }
}
