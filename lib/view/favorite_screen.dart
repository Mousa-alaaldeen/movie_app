// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:mov/util/api_url.dart';
import 'package:mov/util/constants.dart';
import 'package:mov/widget/movie_detail.dart';

class FavoriteScreen extends GetView<HomeController> {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: controller.favoriteList.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.favoriteList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                              MovieDetailScreen(
                                deleteRate: () async {
                                  try {
                                    await Get.find<HomeController>().deleteRate(
                                      movieId:
                                          controller.favoriteList[index].id!,
                                    );
                                    print('تم حذف التقييم بنجاح');
                                  } catch (error) {
                                    print('حدث خطأ أثناء حذف التقييم: $error');
                                  }
                                },
                                voteCount: controller
                                    .favoriteList[index].voteCount
                                    .toString(),
                                movieId: controller.favoriteList[index].id!,
                                imageUrl:
                                    "$baseUrlImag${controller.favoriteList[index].backdropPath}",
                                title: controller
                                    .favoriteList[index].originalTitle!,
                                year: controller
                                    .favoriteList[index].releaseDate!
                                    .toString(),
                                originalTitle: controller
                                    .favoriteList[index].originalTitle!,
                                overview:
                                    controller.favoriteList[index].overview!,
                                onRatingUpdate: (rating) {
                                  Get.find<HomeController>().setRate(
                                      movieId:
                                          controller.favoriteList[index].id!,
                                      val: rating);

                                  print('تم تعيين التقييم بنجاح: $rating');
                                },
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl:
                                    "$baseUrlImag${controller.favoriteList[index].backdropPath}",
                                height: 120,
                                width: 120,
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  controller.favoriteList[index].originalTitle
                                      .toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: kBoldedSubtitleTextSyule,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  controller.setFavorite(
                                    mediaId: controller.favoriteList[index].id!,
                                    favorite: false,
                                    mediaType: 'movie',
                                  );
                                },
                                icon: CircleAvatar(
                                  radius: 15,
                                  // backgroundColor: Get.find<HomeController>().favorites[list]?,
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 10),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Favorites list is empty',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.favorite_border,
                          size: 180,
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
