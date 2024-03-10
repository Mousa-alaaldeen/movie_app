// ignore_for_file: unnecessary_string_interpolations, avoid_print, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/model/model.dart';
import 'package:dio/dio.dart';
import 'package:mov/util/api_url.dart';
import 'package:mov/util/constants.dart';

class TopRatedBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TopRatedController(), permanent: true);
  }
}

class TopRatedController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  bool isLoding = false;
  List<Results> list = [];
  late AnimationController animationController;
  late Animation<Offset> animation;

  List<dynamic>? results;
  void getData() async {
    isLoding = true;
    update();
    var response = await Dio().get(
        "https://api.themoviedb.org/3/movie/top_rated?api_key=7520ef7694f155dc2802d75ec51b5d4b");
    results = response.data['results'];
    print(response);
    for (var e in results!) {
      list.add(Results.fromJsonObjectModel(e));
    }
    isLoding = false;
    update();
  }

  Future setRate({required int movieId, required double value}) async {
    update();

    final jsonData = json.encode({'value': value});

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
      print('sucsses');

      update();
    }).catchError((onError) {
      print(onError);
      // Get.defaultDialog(
      //   title: 'ata qga;lsd',
      //   onConfirm: () {},
      // );
    });
  }
}
