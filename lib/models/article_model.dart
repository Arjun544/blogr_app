
class ArticleModel {
  String id;
  String searchKey;
  String title;
  String desc;
  String categoryType;
  String authorPic;
  String imageUrl;
  int comments;
  List<String> bookMarks;
  List<String> likes;
  DateTime addedOn;
  String addedBy;

  ArticleModel(
      {this.id,
      this.searchKey,
      this.desc,
      this.categoryType,
      this.authorPic,
      this.title,
      this.comments,
      this.imageUrl,
      this.likes,
      this.bookMarks,
      this.addedBy,
      this.addedOn});

  Map toMap(ArticleModel article) {
    var data = Map<String, dynamic>();
    data['id'] = article.id;
    data['searchKey'] = article.searchKey;
    data['title'] = article.title;
    data['desc'] = article.desc;
    data['category'] = article.categoryType;
    data["imageUrl"] = article.imageUrl;
    data["authorPic"] = article.authorPic;
    data['comments'] = article.comments;
    data['bookMarks'] = article.bookMarks;
    data['likes'] = article.likes;
    data['addedOn'] = article.addedOn;
    data['addedBy'] = article.addedBy;
    return data;
  }

  // Named constructor
  ArticleModel.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['id'];
    this.id = mapData['searchKey'];
    this.title = mapData['title'];
    this.desc = mapData['desc'];
    this.categoryType = mapData['category'];
    this.imageUrl = mapData['imageUrl'];
    this.authorPic = mapData['authorPic'];
    this.comments = mapData['comments'];
    this.bookMarks = mapData['bookMarks'];
    this.likes = mapData['likes'];
    this.addedOn = mapData['addedOn'];
    this.addedBy = mapData['addedBy'];
  }
}
