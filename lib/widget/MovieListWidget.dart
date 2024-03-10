// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:mov/model/model.dart';
import 'package:mov/util/constants.dart';
import 'package:get/get.dart';
import 'package:mov/widget/movie_detail.dart';

class MovieListWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final List<Results> list;
  final Function()? onPressedFav;

  const MovieListWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.list,
      this.onPressedFav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: text1,
                  style: TextStyle(
                    color: kRedColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              TextSpan(text: text2, style: kTitleTextStyle),
            ]),
          ),
          SizedBox(
            height: 15,
          ),
          list.isEmpty
              ? CircularProgressIndicator()
              : Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: AspectRatio(
                            aspectRatio: 1 / 1.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 175,
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        'https://image.tmdb.org/t/p/original/${list[index].posterPath}',
                                      ))),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(height: 175,
                                      alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            stops: [0.2, 0.9],
                                            colors: [
                                              Colors.black.withOpacity(0.9),
                                              Colors.black.withOpacity(0.3),
                                            ],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Text(
                                            list[index].originalTitle ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                               IconButton(
                                              onPressed: () {
                                                Get.find<HomeController>()
                                                    .setFavorite(
                                                  mediaId: list[index].id!,
                                                  favorite: true,
                                                  mediaType: 'movie',
                                                );
                                              },
                                              icon: CircleAvatar(
                                                radius: 15,
                                                // backgroundColor: Get.find<HomeController>().favorites[list]?,
                                                child: Icon(
                                               Get.find<HomeController>().favoriteList.any((element) => element.id==list[index].id)?   Icons.favorite:Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                // progressBar(),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.to(
                              MovieDetailScreen(
                                
                              voteCount: list[index].voteCount.toString(),
                              movieId: list[index].id!,
                              imageUrl: list[index].backdropPath!,
                              title: list[index].originalTitle!,
                              year: list[index].releaseDate!.toString(),
                              originalTitle: list[index].originalTitle!,
                              overview: list[index].overview!,
                              onRatingUpdate: (rating) {
                                Get.find<HomeController>().setRate(
                                    movieId: list[index].id!, val: rating);

                                print('تم تعيين التقييم بنجاح: $rating');
                              },
                              initialRating: list[index].voteAverage!,
                              deleteRate: () async {
                                try {
                                  await Get.find<HomeController>().deleteRate(
                                    movieId: list[index].id!,
                                  );

                                  print('تم حذف التقييم بنجاح');
                                } catch (error) {
                                  print('حدث خطأ أثناء حذف التقييم: $error');
                                }
                              },
                            ));
                          },
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
