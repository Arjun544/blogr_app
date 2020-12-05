import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'comments_bottomSheet.dart';

class ArticleOptions extends StatelessWidget {
  final DocumentSnapshot articles;

  ArticleOptions({this.articles});
  final ArticlesController articlesController = Get.find<ArticlesController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('articles')
            .doc(articles.data()['id'])
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return SizedBox();
          }
          return Padding(
            padding:
                const EdgeInsets.only(top: 15, right: 30, left: 30, bottom: 15),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    articlesController.likeArticle(articles.data()['id']);
                  },
                  child: Row(
                    children: [
                      Text(
                        snapshot.data.data()['likes'].length.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.blackColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/Heart.svg',
                        height: 22,
                        color: snapshot.data
                                .data()['likes']
                                .contains(articlesController.currentUser.uid)
                            ? Colors.pink
                            : Colors.grey.withOpacity(0.9),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                            CommentsBottomSheet(
                              articles: articles,
                            ),
                            enableDrag: true,
                            isScrollControlled: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              snapshot.data.data()['comments'].toString(),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.blackColor,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              'assets/Chat.svg',
                              height: 22,
                              color: Colors.grey.withOpacity(0.9),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    articlesController.bookMarkArticle(articles.data()['id']);
                  },
                  child: SvgPicture.asset(
                    'assets/Bookmark.svg',
                    height: 30,
                    color: snapshot.data
                            .data()["bookMarks"]
                            .contains(articlesController.currentUser.uid)
                        ? Colors.black
                        : Colors.grey.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
