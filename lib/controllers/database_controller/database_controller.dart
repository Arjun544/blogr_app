import 'dart:io';
import 'dart:math';

import 'package:blogr_app/models/article_model.dart';
import 'package:blogr_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  ArticleModel articleModel;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection('users');
  static final CollectionReference _articlesCollection =
      _firestore.collection('articles');

  Reference profile = FirebaseStorage.instance.ref().child('articlesImage');

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomId(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  void addDataToDb(var currentUser) async {
    try {
      UserModel user = UserModel(
        uid: currentUser.uid,
        email: currentUser.email,
        profilePhoto: currentUser.photoURL,
        username: currentUser.displayName,
        followers: [],
        following: ['a'],
      );
      await _userCollection.doc(currentUser.uid).set(user.toMap(user));
    } catch (e) {
      print(e);
    }
  }

  Future<void> userFollowers({
    String id,
    String userId,
    String displayName,
    String email,
    String profilePic,
  }) async {
    DocumentSnapshot doc = await _userCollection.doc(id).get();
    if (doc.data()['followers'].contains(userId)) {
      await _userCollection.doc(id).update({
        'followers': FieldValue.arrayRemove([userId])
      });
      await _userCollection
          .doc(id)
          .collection('followers')
          .doc(userId)
          .delete();
    } else {
      await _userCollection.doc(id).update({
        'followers': FieldValue.arrayUnion([userId])
      });
      await _userCollection.doc(id).collection('followers').doc(userId).set({
        'uid': userId,
        'username': displayName,
        'email': email,
        'profile_photo': profilePic,
      });
    }
  }

  Future<void> userFollowings({
    String id,
    String userId,
    String displayName,
    String email,
    String profilePic,
  }) async {
    DocumentSnapshot doc = await _userCollection.doc(id).get();
    if (doc.data()['following'].contains(userId)) {
      await _userCollection.doc(id).update({
        'following': FieldValue.arrayRemove([userId])
      });
      await _userCollection
          .doc(id)
          .collection('followings')
          .doc(userId)
          .delete();
    } else {
      await _userCollection.doc(id).update({
        'following': FieldValue.arrayUnion([userId])
      });
      await _userCollection.doc(id).collection('followings').doc(userId).set({
        'uid': userId,
        'username': displayName,
        'email': email,
        'profile_photo': profilePic,
      });
    }
  }

  Future<String> uploadArticleImage(String userId, File imagePath) async {
    UploadTask storageUploadTask = profile.child(userId).putFile(imagePath);
    TaskSnapshot storageTaskSnapshot = await storageUploadTask;
    String downloadurl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }

  Future<void> commentOnArticle({
    String userId,
    String commentBy,
    String articleId,
    String profilePic,
    String commentText,
  }) async {
    var doc =
        await _articlesCollection.doc(articleId).collection('comments').get();
    int length = doc.docs.length;
    await _articlesCollection
        .doc(articleId)
        .collection('comments')
        .doc('comment $length')
        .set({
      'uid': userId,
      'commentBy': commentBy,
      'profilePic': profilePic,
      'comment': commentText,
      'time': DateTime.now(),
      'likes': [],
    });
    DocumentSnapshot documentSnapshot =
        await _articlesCollection.doc(articleId).get();
    await _articlesCollection.doc(articleId).update({
      'comments': documentSnapshot.data()['comments'] + 1,
    });
  }

  Future<void> bookMarkArticle({
    String userId,
    String articleId,
  }) async {
    DocumentSnapshot doc = await _articlesCollection.doc(articleId).get();
    if (doc.data()['bookMarks'].contains(userId)) {
      await _articlesCollection.doc(articleId).update({
        'bookMarks': FieldValue.arrayRemove([userId])
      });
    } else {
      await _articlesCollection.doc(articleId).update({
        'bookMarks': FieldValue.arrayUnion([userId])
      });
    }
    update();
  }

  Future<void> likeArticle(String userId, String articleId) async {
    DocumentSnapshot doc = await _articlesCollection.doc(articleId).get();
    if (doc.data()['likes'].contains(userId)) {
      await _articlesCollection.doc(articleId).update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      await _articlesCollection.doc(articleId).update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }

  Future<void> deleteArticle(String articleId) async {
    await _articlesCollection.doc(articleId).delete();
    update();
  }

  Future<void> saveArticle({
    String userId,
    String title,
    String desc,
    String imageUrl,
    String authorPic,
    String addedBy,
    String category,
  }) async {
    String docId = getRandomId(28);
    ArticleModel articleModel = ArticleModel(
        id: docId,
        userId: userId,
        addedOn: DateTime.now(),
        addedBy: addedBy,
        title: title,
        likes: [],
        bookMarks: [],
        comments: 0,
        authorPic: authorPic,
        desc: desc,
        imageUrl: imageUrl,
        categoryType: category);
    await _articlesCollection.doc(docId).set(
          articleModel.toMap(articleModel),
        );
  }

  Future<UserModel> getUserDetailsById(String userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _userCollection.doc(userId).get();
      return UserModel.fromMap(documentSnapshot.data());
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getSearchResults(String searchKey) {
    return _articlesCollection
        .where('title', isGreaterThanOrEqualTo: searchKey)
        .where('title', isLessThan: searchKey + 'z')
        .get()
        .then((value) => value.docs);
  }
}
