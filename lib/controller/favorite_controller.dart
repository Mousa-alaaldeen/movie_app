// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/model/model.dart';
import 'package:dio/dio.dart';
import 'package:mov/util/api_url.dart';
import 'package:mov/util/constants.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController(), permanent: true);
  }
}

class FavoriteController extends GetxController {
  List<Results> favoriteList = [];
  List<dynamic>? results;
  void onInit() {
    super.onInit();
    // fetchMovies();
  }

 
}
