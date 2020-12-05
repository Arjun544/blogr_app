import 'dart:ui';

import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:blogr_app/views/articles_screen/components/article_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'components/top_appbar.dart';

class ArticlesScreen extends StatelessWidget {
  static final String routeName = 'articles screen';

  final ArticlesController articlesController = Get.find<ArticlesController>();

  ArticlesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Get.height;
    final double screenWidth = Get.width;
    var date = DateTime.now();
    date = DateTime(date.year, date.month, date.day);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: TopAppBar(),
      extendBody: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Today's Read",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ).copyWith(
                          color: Theme.of(context).textTheme.headline1.color),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.32,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('articles')
                          .where('addedOn', isGreaterThanOrEqualTo: date)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData && snapshot.data == null) {
                          return Center(child: Lottie.asset('assets/loading.json'));
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.docs.length,
                            padding: EdgeInsets.only(left: 15),
                            itemBuilder: (context, index) {
                              DocumentSnapshot todaysArticles =
                                  snapshot.data.docs[index];
                              return Container(
                                width: screenWidth * 0.8,
                                margin: EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ArticleTile(
                                  articles: todaysArticles,
                                  isMini: true,
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 27),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ).copyWith(
                          color: Theme.of(context).textTheme.headline1.color),
                        ),
                        Text(
                          "see all",
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: screenHeight * 0.5,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('articles')
                          .orderBy('likes', descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData && snapshot.data == null) {
                          return Lottie.asset('assets/loading.json');
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.docs.length,
                            padding: EdgeInsets.only(left: 25, right: 23),
                            itemBuilder: (context, index) {
                              DocumentSnapshot popularArticles =
                                  snapshot.data.docs[index];
                              // articlesController.article = popularArticles;
                              return Container(
                                height: screenHeight * 0.3,
                                width: screenWidth * 0.8,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: ArticleTile(
                                  articles: popularArticles,
                                  isMini: false,
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
