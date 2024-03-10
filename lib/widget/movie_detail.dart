// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:mov/util/api_url.dart';
import 'package:mov/util/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    required this.movieId,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.originalTitle,
    required this.overview,
    required this.onRatingUpdate,
    required this.deleteRate,
    this.initialRating,
    required this.voteCount,
  });
  final String imageUrl;
  final String title;
  final String originalTitle;
  final String year;
  final String voteCount;
  final int movieId;
  final double? initialRating;
  final String overview;
  final void Function(double) onRatingUpdate;
  final Function() deleteRate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: Get.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "$baseUrlImag$imageUrl",
                ),
              ),
            ),
            child: SafeArea(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //     onPressed: () {
                //       Get.back();
                //     },
                //     icon: CircleAvatar(
                //       child: Icon(
                //         Icons.arrow_back_ios,
                //         color: Colors.white,
                //       ),
                //     ))
              ],
            )),
          ),
          Center(
            child: Text(
              title,
              style: kSubheadingextStyle,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: initialRating ?? 0,
                      minRating: 0.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 8,
                      itemSize: 20,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: onRatingUpdate,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.find<HomeController>().setFavorite(
                          mediaId: movieId,
                          favorite: true,
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
                SizedBox(width: 10),
                TextButton(
                  onPressed: deleteRate,
                  child: Text(
                    "Delete rating",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      year,
                      style: kSubtitleTextSyule,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      originalTitle.length > 30
                          ? '${originalTitle.substring(0, 30)}...'
                          : originalTitle,
                      style: kSubtitleTextSyule.copyWith(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text("vote Count"),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      voteCount.toString(),
                      style:
                          TextStyle(height: 2, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  overview,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
