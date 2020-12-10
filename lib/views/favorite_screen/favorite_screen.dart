import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/articles_screen_controller.dart';
import 'package:blogr_app/views/detail_screen/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FavoriteScreen extends StatelessWidget {
  static final String routeName = 'favorite screen';
  FavoriteScreen({Key key}) : super(key: key);

  final ArticlesScreenController articlesController = Get.find<ArticlesScreenController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Saved articles',
          style: TextStyle()
              .copyWith(color: Theme.of(context).textTheme.headline1.color),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('articles')
              .where('bookMarks',
                  arrayContains: articlesController.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData && snapshot.data == null) {
              return Lottie.asset('assets/loading.json');
            }
            if (snapshot.data.docs.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/no articles.json'),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No bookmarks',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.headline1.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      DetailScreen(
                        articles: documentSnapshot,
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Center(
                        child: Container(
                          height: screenHeight * 0.18,
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.35,
                              top: screenHeight * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        documentSnapshot.data()['title'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ).copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                .color),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        articlesController.bookMarkArticle(
                                            documentSnapshot.data()['id']);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          documentSnapshot
                                              .data()['likes']
                                              .length
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ).copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .color),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SvgPicture.asset('assets/Heart.svg',
                                            height: 22, color: Colors.pink),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          documentSnapshot
                                              .data()['comments']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ).copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .color),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SvgPicture.asset(
                                          'assets/Chat.svg',
                                          height: 22,
                                          color: CustomColors.greyColor
                                              .withOpacity(0.7),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.25,
                        margin: EdgeInsets.fromLTRB(30, 0, 10, 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              documentSnapshot.data()['imageUrl'],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
