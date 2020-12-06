import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:blogr_app/views/articles_screen/components/reading_time.dart';
import 'package:blogr_app/views/users_profile_screen/users_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WriterInfo extends StatelessWidget {
  final DocumentSnapshot articles;

  final ArticlesController articlesController = Get.find<ArticlesController>();

  WriterInfo({@required this.articles});

  @override
  Widget build(BuildContext context) {
    var readTime = readingTime(articles.data()['desc']);
    return Row(
      children: [
        CircleAvatar(
          radius: 27,
          backgroundImage: CachedNetworkImageProvider(
            articles.data()['authorPic'],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              articles.data()['userId'] == articlesController.currentUser.uid
                  ? SizedBox()
                  : Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return UsersProfile(
                          user: articles.data()['userId'],
                        );
                      }),
                    );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articles.data()['addedBy'],
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ).copyWith(
                      color: Theme.of(context).textTheme.headline1.color),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      DateFormat.MMMEd().format(
                        articles.data()['addedOn'].toDate(),
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.greyColor,
                      ),
                    ),
                    Container(
                      height: 5,
                      width: 5,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                    ),
                    Text(
                      readTime['text'],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.greyColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Icon(
          Icons.more_horiz,
          color: Theme.of(context).textTheme.headline1.color,
        ),
      ],
    );
  }
}
