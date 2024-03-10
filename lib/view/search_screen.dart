// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, unnecessary_import, unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:mov/controller/search_controller.dart';
import 'package:mov/util/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mov/util/constants.dart';
import 'package:mov/widget/movie_detail.dart';

class SearchScreen extends GetView<SearchControllerr> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: GetBuilder<SearchControllerr>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CupertinoSearchTextField(
                padding: EdgeInsets.all(10),
                controller: controller.SearchC,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                style: TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  controller.Search(value);
                },
              ),
              GetBuilder<SearchControllerr>(builder: (cont) {
                if (cont.SearchList.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.SearchList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // print('00');
                            Get.to(MovieDetailScreen(
                              deleteRate: () async {
                                try {
                                  await Get.find<HomeController>().deleteRate(
                                    movieId: controller.SearchList[index].id!,
                                  );
                                  print('تم حذف التقييم بنجاح');
                                } catch (error) {
                                  print('حدث خطأ أثناء حذف التقييم: $error');
                                }
                              },
                              voteCount: controller.SearchList[index].voteCount
                                  .toString(),
                              movieId: controller.SearchList[index].id!,
                              imageUrl:
                                  controller.SearchList[index].backdropPath!,
                              title:
                                  controller.SearchList[index].originalTitle!,
                              year: controller.SearchList[index].releaseDate!
                                  .toString(),
                              originalTitle:
                                  controller.SearchList[index].originalTitle!,
                              overview: controller.SearchList[index].overview!,
                              onRatingUpdate: (rating) {
                                Get.find<HomeController>().setRate(
                                    movieId: controller.SearchList[index].id!,
                                    val: rating);

                                print('تم تعيين التقييم بنجاح: $rating');
                              },
                            ));
                          },
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    "${baseUrlImag}${controller.SearchList[index].backdropPath}",
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
                                  controller.SearchList[index].originalTitle
                                      .toString(),
                                  style: kBoldedSubtitleTextSyule,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        );
      }),
    ));
  }
}
