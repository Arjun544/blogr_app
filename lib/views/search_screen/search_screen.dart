import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';

import 'package:blogr_app/views/articles_screen/components/article_tile.dart';
import 'package:blogr_app/views/detail_screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final DatabaseController databaseController = Get.find<DatabaseController>();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 10, top: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Theme.of(context).textTheme.headline1.color,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TypeAheadField(
                    hideSuggestionsOnKeyboardHide: false,
                    noItemsFoundBuilder: (context) {
                      return Center(
                        child: Container(
                          color: Theme.of(context).backgroundColor,
                          child: Column(
                            children: [
                              Lottie.asset('assets/no articles.json',
                                  height: 150),
                              Text(
                                'Nothing found ',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: textEditingController,
                      autocorrect: false,
                      maxLines: 1,
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        hintText: 'search articles',
                        hintStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 20,
                          color: Colors.white60,
                          fontWeight: FontWeight.w600,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            textEditingController.clear();
                          },
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 20, bottom: 15, top: 15),
                        filled: true,
                        fillColor: CustomColors.bottomBarColor,
                        border: InputBorder.none,
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return await databaseController.getSearchResults(pattern);
                    },
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      shadowColor: Colors.transparent,
                      offsetX: -12,
                    ),
                    suggestionsBoxVerticalOffset: 20,
                    itemBuilder: (context, suggestion) {
                      return textEditingController.text.length == 0
                          ? Container()
                          : Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ArticleTile(
                                    articles: suggestion,
                                    isMini: true,
                                  ),
                                ),
                              ],
                            );
                    },
                    onSuggestionSelected: (suggestion) {
                      Get.to(
                        DetailScreen(
                          articles: suggestion,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
