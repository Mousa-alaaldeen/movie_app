// ignore_for_file: non_constant_identifier_names, unnecessary_overrides, unused_import, depend_on_referenced_packages, unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/model/model.dart';
import 'package:mov/util/api_url.dart';
import 'package:dio/dio.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchControllerr());
  }
}

class SearchControllerr extends GetxController {
  MoviesModel? searchModel;
  final TextEditingController SearchC = TextEditingController();
  bool isLoding = false;
  List<Results>? results = [];
  var headers = {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTIwZWY3Njk0ZjE1NWRjMjgwMmQ3NWVjNTFiNWQ0YiIsInN1YiI6IjY1ZWEzM2VmYWY5NTkwMDE4NGRkZGMyNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.fyzHHB1TJFePAlKrJXPtZIm5mYzPx-1WMjvceC0LxqI",
  };

  List<Results> SearchList = [];

  void Search(String searchText) {
    getSearchData(searchText);
  }

  Future<MoviesModel> getSearchData(String searchText) async {
    SearchList = [];
    String endPoint =
        "search/movie?query=$searchText&api_key=7520ef7694f155dc2802d75ec51b5d4b";
    String url = "$baseUrl$endPoint";
    isLoding = true;
    update();
    var response = await Dio().get("$url", options: Options(headers: headers));
    // results = response.data['results'];
    // print(response);
    print("Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      log("status");
      for (var e in response.data['results']) {
        SearchList.add(Results.fromJsonObjectModel(e));
      }
      print(SearchList.length);
      update();
      return MoviesModel.fromJsonObjectModel(jsonDecode(response.data));
    }

    isLoding = false;
    update();
    throw Exception("Failed to load data. Status code: ${response.statusCode}");
  }
  //=================================

  Future<MoviesModel> getMovieDetail(int movieId) async {
    String endPoint = "movie/$movieId";
    String url = "$baseUrl$endPoint";
    isLoding = true;
    update();
    var response = await Dio().get(
      "$url",
    );
    // results = response.data['results'];
    // print(response);
    print("Status Code: ${response.statusCode}");
    if (response.statusCode == 200) {
      log("status");
      // for (var e in response.data['results']) {
      //   SearchList.add(Results.fromJsonObjectModel(e));
      // }
      // print(SearchList.length);
      // update();
      return MoviesModel.fromJsonObjectModel(jsonDecode(response.data));
    }
    isLoding = false;
    update();
    throw Exception("Failed to load data. Status code: ${response.statusCode}");
  }
}
