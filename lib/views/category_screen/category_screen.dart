import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/models/category_model.dart';
import 'package:blogr_app/views/articles_screen/components/article_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryScreen({@required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: Theme.of(context).appBarTheme.elevation,
        iconTheme: IconThemeData(color: Theme.of(context).appBarTheme.iconTheme.color),
        title: Text(
          category.txt,
          style: TextStyle(color: Theme.of(context).textTheme.headline1.color),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('articles')
            .where('category', isEqualTo: category.txt)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return Lottie.asset('assets/loading.json');
          }
          if (snapshot.data.docs.length == 0) {
            return Center(
              child: Text(
                'No articles in this category',
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).textTheme.headline1.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'Articles',
                      style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).textTheme.headline1.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.headline1.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        snapshot.data.docs.length.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: ArticleTile(
                        articles: documentSnapshot,
                        isMini: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
