import 'dart:ui';
import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class CommentsBottomSheet extends StatelessWidget {
  final DocumentSnapshot articles;

  final DatabaseController databaseController = Get.find<DatabaseController>();
  final ArticlesController articlesController = Get.find<ArticlesController>();
  final TextEditingController commentController = TextEditingController();

  CommentsBottomSheet({@required this.articles});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('articles')
          .doc(articles.data()['id'])
          .collection('comments')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData && snapshot.data == null) {
          return Lottie.asset('assets/loading.json');
        }
        return Container(
          width: Get.mediaQuery.size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 30, bottom: 50),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot comments = snapshot.data.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 30, right: 10, left: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                      comments.data()['profilePic'],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          comments.data()['commentBy'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: CustomColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          DateFormat.MMMEd().format(
                                            comments.data()['time'].toDate(),
                                          ),
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: CustomColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 100,
                                      width: Get.mediaQuery.size.width * 0.7,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                        color: CustomColors.greyColor
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        comments.data()['comment'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: CustomColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 50,
                  width: Get.mediaQuery.size.width,
                  color: CustomColors.blackColor,
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 1),
                          decoration: InputDecoration(
                            hintText: 'Write a comment',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          commentController.text.length != 0
                              ? articlesController.commentOnArticle(
                                  commentController.text, articles.data()['id'])
                              : SizedBox();
                          commentController.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Text(
                          'Publish',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
