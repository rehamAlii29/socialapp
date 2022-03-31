class PostModel {
  String? userId;
  String? name;
  String? userimage;
  String? postImage;
  String? postText;
  String? postTime;
  PostModel(
      {this.userId,
      this.name,
      this.userimage,
      this.postImage,
      this.postText,
      this.postTime});

  PostModel.fromFirebase(Map<String, dynamic> fromfirebase) {
    userId = fromfirebase['userId'];
    name = fromfirebase['name'];
    userimage = fromfirebase['userimage'];
    postImage = fromfirebase['postImage'];
    postText = fromfirebase['postText'];
    postTime = fromfirebase['postTime'];
  }

  Map<String, dynamic> ToFirebase() {
    return {
      'userId': userId,
      'name': name,
      'userimage': userimage,
      'postImage': postImage,
      'postText': postText,
      'postTime': postTime,
    };
  }
}
