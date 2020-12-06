import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:blogr_app/views/articles_screen/components/reading_time.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArticleInfo extends StatelessWidget {
  final DocumentSnapshot articles;
  final double screenHeight;
  final double screenWidth;

  ArticleInfo({
    @required this.articles,
    this.screenHeight,
    this.screenWidth,
  });
  final ArticlesController articlesController = Get.find<ArticlesController>();

  @override
  Widget build(BuildContext context) {
    var readTime = readingTime(articles.data()['desc']);
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 25, top: 20, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                toBeginningOfSentenceCase(
                  articles.data()['category'],
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                readTime['text'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            toBeginningOfSentenceCase(
              articles.data()['title'],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 19,
              color: Theme.of(context).textTheme.headline1.color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Divider(
            color: Colors.blueGrey.withOpacity(0.1),
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: CachedNetworkImageProvider(
                      articles.data()['authorPic'],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    articles.data()['addedBy'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    articles.data()['likes'].length.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline1.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/Heart.svg',
                    height: 17,
                    color: Colors.pink,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
