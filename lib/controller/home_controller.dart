// ignore_for_file: unnecessary_string_interpolations, avoid_print, depend_on_referenced_packages, prefer_const_declarations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/model/model.dart';
import 'package:dio/dio.dart';
import 'package:mov/util/api_url.dart';
import 'dart:convert';
import 'package:mov/util/constants.dart';
import 'package:mov/util/error_dialog.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}

class HomeController extends GetxController {
  late AnimationController animationController;
  late Animation<Offset> animation;
  List<dynamic>? results;
  List<Results> list = [];
  List<Results> nowPlayingList = [];
  List<Results> upcomingList = [];
  List<Results> tVList = [];
  List<String> tVImage = [];
  List<Results> favoriteList = [];
  List<Results> trendingList = [];
  List<Record> ratedMovies = [];

  @override
  void onInit() {
    super.onInit();
    getFavoriteMovies();
    getTVData();
    getNowPlayingData();
    getupcomingData();

  getPopularData();
  }

  void getupcomingData() async {
    var response = await Dio().get("$upcoming");
    results = response.data['results'];

    for (var e in results!) {
      upcomingList.add(Results.fromJsonObjectModel(e));
    }
  }
//=========================================

  void getNowPlayingData() async {
    var response = await Dio().get("$nowPlaying");
    results = response.data['results'];
    // print("Status Code: ${response.statusCode}");

    for (var e in results!) {
      nowPlayingList.add(Results.fromJsonObjectModel(e));
    }
    print(nowPlayingList);
  }

//==========================================
  void getTVData() async {
    var response = await Dio().get("$tV").then((response) {
      results = response.data['results'];
      for (var e in results!) {
        //https://image.tmdb.org/t/p/w500/${controller.upcomingList[index].posterPath}
        tVImage.add("https://image.tmdb.org/t/p/w500/${e['poster_path']}");
        tVList.add(Results.fromJsonObjectModel(e));
      }
      update();
    }).catchError((onError) {
      Get.dialog(ErrorDialogWidget());
    });
  }

  void getPopularData() {
    update();
    Dio()
        .get(
      "${baseUrl}discover/movie${key}",
    )
        .then((response) {
      print('sucsses');

      results = response.data['results'];
      for (var e in results!) {
        list.add(Results.fromJsonObjectModel(e));
      }

      update();
    }).catchError((onError) {
      Get.dialog(ErrorDialogWidget());
    });
  }

  void getTrendingData() async {
    update();
    Dio().get("$trending").then((response) {
      results = response.data['results'];

      for (var e in results!) {
        trendingList.add(Results.fromJsonObjectModel(e));
      }

      update();
    }).catchError((onError) {
      Get.dialog(ErrorDialogWidget());
    });
  }

  Future setFavorite({
    required int mediaId,
    required bool favorite,
    required String mediaType,
  }) async {
    update();

    return await Dio()
        .post(
      '${baseUrl}account/21073642/favorite',
      data: {
        "media_type": mediaType,
        "media_id": mediaId,
        "favorite": favorite
      },
      options: Options(
        headers: {
          'Authorization': ' Bearer $token',
          'accept': 'application/json',
          'content-type': 'application/json',
        },
      ),
    )
        .then((value) {
      if (favorite == true) {
        Get.snackbar(
          'Added',
          'The movie has been successfully added to favorites!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        getFavoriteMovies();
      } else {
        Get.snackbar(
          'Removed',
          'The movie has been successfully removed from favorites!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      update();

      print('sucsses');
      update();
    }).catchError((onError) {
      print(onError);
    });
  }

  Future setRate({required int movieId, required double val}) async {
    update();

    final jsonData = json.encode({'value': val});

    return await Dio()
        .post(
      '${baseUrl}movie/$movieId/rating',
      data: jsonData,
      options: Options(
        headers: {
          'Authorization': ' Bearer $token',
          'Content-Type': 'application/json;charset=utf-',
          'accept': 'application/json',
        },
      ),
    )
        .then((value) {
      Get.snackbar(
        'Rating Added',
        'Rating added successfully! ${val}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      print('sucsses');

      update();
    }).catchError((onError) {
      print(onError);
      Get.snackbar(
        'Error',
        'An error occurred while adding the rating',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
  }

  Future deleteRate({
    required int movieId,
  }) async {
    update();

    return await Dio()
        .delete('${baseUrl}movie/$movieId/rating',
            options: Options(headers: {
              'Authorization': ' Bearer $token',
              'Content-Type': 'application/json;charset=utf-',
              'accept': 'application/json',
            }))
        .then((value) {
      print('sucsses');
      Get.snackbar(
        'Rating Deleted',
        'Rating deleted successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      update();
    }).catchError((onError) {
      Get.snackbar(
        'Error',
        'An error occurred while deleting the rating.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    });
  }

  Future getFavoriteMovies() {
    favoriteList = [];
    return Dio()
        .get('${baseUrl}account/21073642/favorite/movies',
            options: Options(headers: {
              'Authorization': ' Bearer $token',
              'accept': 'application/json',
              'content-type': 'application/json',
            }))
        .then((response) {
      print('00000000000000000000000000000000');
      results = response.data['results'];

      print('Request failed with status: ${response.statusCode}');
      for (var e in results!) {
        favoriteList.add(Results.fromJsonObjectModel(e));
      }
    }).catchError((error) {
      print('Request failed with status: ${error.statusCode}');
      Get.dialog(ErrorDialogWidget());
    });
  }
}
