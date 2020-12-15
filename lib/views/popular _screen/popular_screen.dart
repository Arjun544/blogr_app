import 'package:blogr_app/views/articles_screen/components/article_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PopularScreen extends StatelessWidget {
  static final String routeName = 'popular screen';
  const PopularScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'Popular articles',
            style: TextStyle()
                .copyWith(color: Theme.of(context).textTheme.headline1.color),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('articles')
              .orderBy('likes', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData && snapshot.data == null) {
              return Lottie.asset('assets/loading.json');
            }
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                itemBuilder: (context, index) {
                  DocumentSnapshot popularArticles = snapshot.data.docs[index];
                  return Container(
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
    );
  }
}
