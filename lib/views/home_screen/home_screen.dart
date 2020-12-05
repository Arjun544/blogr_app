import 'package:blogr_app/controllers/home_screen_controller.dart';
import 'package:blogr_app/views/articles_screen/articles_screen.dart';
import 'package:blogr_app/views/favorite_screen/favorite_screen.dart';
import 'package:blogr_app/views/home_screen/components/customFloatingButton.dart';
import 'package:blogr_app/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/custom_bottom_appbar.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = 'home screen';

  const HomeScreen({Key key}) : super(key: key);

  static List<Widget> _children = [
    ArticlesScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: _children[controller.currentIndex],
            extendBody: true,
            bottomNavigationBar: CustomBottomAppBar(
              height: 80,
              iconSize: 30,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              color: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedItemColor,
              selectedColor:
                  Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              notchedShape: CircularNotchedRectangle(),
              onTabSelected: controller.selectedTab,
              items: [
                BottomAppBarItem(
                  icon: 'assets/Home.svg',
                ),
                BottomAppBarItem(
                  icon: 'assets/Bookmark.svg',
                ),
                BottomAppBarItem(
                  icon: 'assets/Profile.svg',
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: controller.currentIndex == 2
                ? Container()
                : SizedBox(
                    height: 70,
                    width: 70,
                    child: CustomFloatingButton(),
                  ),
          );
        });
  }
}
