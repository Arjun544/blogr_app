class UserModel {
  String uid;
  String email;
  String username;
  String profilePhoto;


  UserModel({
    this.uid,
    this.email,
    this.username,
    this.profilePhoto,
  });

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['email'] = user.email;
    data['username'] = user.username;
    data["profile_photo"] = user.profilePhoto;
    return data;
  }

  // Named constructor
  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.profilePhoto = mapData['profile_photo'];
  }
}
