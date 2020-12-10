class UserModel {
  String uid;
  String email;
  String username;
  String profilePhoto;
  List<dynamic> followers;
  List<String> following;

  UserModel({
    this.uid,
    this.email,
    this.username,
    this.profilePhoto,
    this.followers,
    this.following,
  });

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['email'] = user.email;
    data['username'] = user.username;
    data["profile_photo"] = user.profilePhoto;
    data["followers"] = user.followers;
    data["following"] = user.following;
    return data;
  }

  // Named constructor
  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.profilePhoto = mapData['profile_photo'];
    this.followers = mapData['followers'];
    this.following = mapData['following'];
  }
}
