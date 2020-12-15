import 'dart:ui';

import 'package:blogr_app/controllers/articles_screen_controller.dart';
import 'package:blogr_app/controllers/profile_screen_controller.dart';
import 'package:blogr_app/views/articles_screen/components/article_tile.dart';
import 'package:blogr_app/views/popular%20_screen/popular_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'components/top_appbar.dart';

class ArticlesScreen extends StatelessWidget {
  static final String routeName = 'articles screen';

  final ArticlesScreenController articlesScreenController =
      Get.find<ArticlesScreenController>();

  final ProfileScreenController profileScreenController =
      Get.find<ProfileScreenController>();
  int selectedIndex;
  int docsLength;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Get.height;
    final double screenWidth = Get.width;

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: TopAppBar(),
      extendBody: true,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
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
                        "Following",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ).copyWith(
                            color: Theme.of(context).textTheme.headline1.color),
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> futureSnapShot) {
                          if (!futureSnapShot.hasData &&
                              futureSnapShot.data == null) {
                            return SizedBox();
                          }
                          DocumentSnapshot documentSnapshot =
                              futureSnapShot.data;
                          return Container(
                            height: screenHeight * 0.32,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('articles')
                                  .where('userId',
                                      whereIn: documentSnapshot['following'])
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                print(documentSnapshot['following']);
                                if (!snapshot.hasData &&
                                    snapshot.data == null) {
                                  return Center(
                                    child: Lottie.asset('assets/loading.json'),
                                  );
                                }
                                if (snapshot.data.docs.length == 0) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset('assets/no articles.json',
                                            height: 140),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'No body yet',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                .color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.docs.length,
                                    padding: EdgeInsets.only(left: 15),
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot followingArticles =
                                          snapshot.data.docs[index];
                                      return Container(
                                        width: screenWidth * 0.8,
                                        margin: EdgeInsets.only(right: 6),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: ArticleTile(
                                          articles: followingArticles,
                                          isMini: true,
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                        }),
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
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .color),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(PopularScreen.routeName);
                            },
                            child: Text(
                              "see all",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white60),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          height: screenHeight * 0.57,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('articles')
                                .orderBy('likes', descending: false)
                                .limit(10)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData && snapshot.data == null) {
                                return Lottie.asset('assets/loading.json');
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.docs.length,
                                  padding: EdgeInsets.only(left: 25, right: 23),
                                  itemBuilder: (context, index) {
                                    selectedIndex = index;
                                    docsLength = snapshot.data.docs.length - 1;
                                    DocumentSnapshot popularArticles =
                                        snapshot.data.docs[index];
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
                        selectedIndex == docsLength
                            ? GestureDetector(
                                onTap: () {
                                  Get.toNamed(PopularScreen.routeName);
                                },
                                child: Text(
                                  'see all',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 22),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
