import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('articles')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GlobalKey<AutoCompleteTextFieldState<ArticleModel>> key =
      new GlobalKey();

  AutoCompleteTextField searchTextField;
  var articleData;

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    getArticlesList();
    super.initState();
  }

  Stream<List<ArticleModel>> getArticlesList() {
    return FirebaseFirestore.instance.collection('articles').snapshots().map(
        (snapshot) => snapshot.docs
            .map((document) => ArticleModel.fromMap(document.data()))
            .toList());
  }
  // var queryResultSet = [];
  // var tempSearchStore = [];

  // initiateSearch(value) {
  //   if (value.length == 0) {
  //     setState(() {
  //       queryResultSet = [];
  //       tempSearchStore = [];
  //     });
  //   }

  //   if (queryResultSet.length == 0 && value.length == 1) {
  //     SearchService().searchByName(value).then((QuerySnapshot docs) {
  //       for (int i = 0; i < docs.docs.length; ++i) {
  //         queryResultSet.add(docs.docs[i].data());
  //         setState(() {
  //           tempSearchStore.add(queryResultSet[i]);
  //         });
  //       }
  //     });
  //   } else {
  //     queryResultSet.forEach((element) {
  //       if (element['title'].toLowerCase().contains(value.toLowerCase()) ==
  //           true) {
  //         if (element['title'].toLowerCase().atIndex(value.toLowerCase()) ==
  //             0) {
  //           setState(() {
  //             tempSearchStore.add(element);
  //           });
  //         }
  //       }
  //     });
  //   }
  //   if (tempSearchStore.length == 0 && value.length > 1) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: CustomColors.blackColor),
        title: StreamBuilder(
            stream: getArticlesList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData && snapshot.data == null) {
                return Lottie.asset('assets/loading.json');
              }
              articleData = snapshot.data;
              return AutoCompleteTextField<ArticleModel>(
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  decoration: InputDecoration(
                      suffixIcon: Container(
                        width: 85.0,
                        height: 60.0,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      filled: true,
                      hintText: 'Search Player Name',
                      hintStyle: TextStyle(color: Colors.black)),
                  itemSubmitted: (item) {
                    setState(() => searchTextField.textField.controller.text =
                        item.searchKey);
                  },
                  clearOnSubmit: false,
                  key: key,
                  suggestions: articleData,
                  itemBuilder: (context, item) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                        ),
                        Text(
                          item.desc,
                        )
                      ],
                    );
                  },
                  itemSorter: (a, b) {
                    return a.searchKey.compareTo(b.searchKey);
                  },
                  itemFilter: (item, query) {
                    return item.searchKey
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  });
            }),

        // title: TextField(
        //   onChanged: (val) {
        //     initiateSearch(val);
        //   },
        //   decoration: InputDecoration(
        //     hintText: 'Search here',
        //     hintStyle: TextStyle(
        //       color: CustomColors.greyColor,
        //       fontWeight: FontWeight.bold,
        //     ),
        //     border: InputBorder.none,
        //   ),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/Search.svg',
              color: CustomColors.greyColor,
              height: 26,
            ),
          ),
        ],
      ),
      body: Container(),
      // body: ListView(
      //   padding: EdgeInsets.only(left: 10.0, right: 10.0),
      //   shrinkWrap: true,
      //   children: tempSearchStore.map((element) {
      //     return SearchResults(
      //       data: element,
      //     );
      //   }).toList(),
      // ),
    );
  }
}
