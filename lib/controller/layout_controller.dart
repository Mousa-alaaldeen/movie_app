import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mov/controller/home_controller.dart';
import 'package:mov/controller/search_controller.dart';
import 'package:mov/controller/top_rated_controller.dart';
import 'package:mov/view/favorite_screen.dart';
import 'package:mov/view/home_screen.dart';
import 'package:mov/view/search_screen.dart';
import 'package:mov/view/top_rated_screen.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LayoutControllerr());
    Get.put(HomeController());
    Get.put(SearchControllerr());
    Get.put(TopRatedController());
  }
}

class LayoutControllerr extends GetxController {
  List<Widget> bottom = [
    const NavigationDestination(
        icon: Icon(Icons.tv), label: 'Home', selectedIcon: Icon(Icons.tv)),
    const NavigationDestination(
      icon: Icon(Icons.search_sharp),
      label: 'Search',
      selectedIcon: Icon(Icons.search),
    ),
    const NavigationDestination(
      icon: Icon(Icons.favorite_outline),
      label: 'Favorites',
      selectedIcon: Icon(Icons.favorite),
    ),
    const NavigationDestination(
      icon: Icon(Icons.star_outlined),
      label: 'Top Rated',
      selectedIcon: Icon(Icons.star),
    ),
  ];
  List<Widget> bottomScreen = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const TopRatedScreen(),
  ];

  int carrentIndex = 0;
  void changeBottom(index) {
    carrentIndex = index;
    update();
  }
}
