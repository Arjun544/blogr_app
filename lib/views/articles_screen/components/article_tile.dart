import 'package:blogr_app/controllers/articles_screen_controller.dart';
import 'package:blogr_app/views/articles_screen/components/article_info.dart';
import 'package:blogr_app/views/detail_screen/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleTile extends StatelessWidget {
  final bool isMini;
  final DocumentSnapshot articles;

  ArticleTile({this.isMini, @required this.articles});

  final ArticlesScreenController articlesController = Get.find<ArticlesScreenController>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = Get.mediaQuery.size.height;
    final double screenWidth = Get.mediaQuery.size.width;

    return InkWell(
      onTap: () {
        Get.to(
          DetailScreen(
            articles: articles,
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              imageUrl: articles.data()['imageUrl'],
              fit: BoxFit.cover,
              height: screenHeight * 0.3,
              width: isMini ? screenWidth * 0.75 : screenWidth * 0.865,
            ),
          ),
          Container(
            height: screenHeight * 0.18,
            width: isMini ? screenWidth * 0.7 : screenWidth * 0.8,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ArticleInfo(
              articles: articles,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
          ),
        ],
      ),
    );
  }
}
