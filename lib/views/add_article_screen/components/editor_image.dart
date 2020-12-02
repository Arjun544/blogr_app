import 'dart:io';

import 'package:blogr_app/controllers/add_article_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr_plus/zefyr.dart';

class EditorAddImage implements ZefyrImageDelegate<ImageSource> {
  final AddArticleController addArticleController =
      Get.find<AddArticleController>();
      
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    addArticleController.file = await ImagePicker.pickImage(source: source);
    if (addArticleController.file == null) return null;
    // We simply return the absolute path to selected file.
    return addArticleController.file.uri.toString();
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    addArticleController.file = File.fromUri(Uri.parse(key));

    /// Create standard [FileImage] provider. If [key] was an HTTP link
    /// we could use [NetworkImage] instead.
    final image = FileImage(addArticleController.file);
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image(
        image: image,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
