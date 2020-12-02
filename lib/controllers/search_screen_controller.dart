import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:blogr_app/models/article_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  GlobalKey<AutoCompleteTextFieldState<ArticleModel>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();

  initiateSearch() {
    
    update();
  }
}
