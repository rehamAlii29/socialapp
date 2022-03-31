class Commentmodel {
  String? postid;
  String? userid;
  String? username;
  String? userimage;
  String? commentText;
  Commentmodel(
      {this.postid,
      this.userid,
      this.username,
      this.userimage,
      this.commentText});

  Commentmodel.fromFibrebase(Map<String, dynamic> fromfirebase) {
    postid = fromfirebase['postid'];
    userid = fromfirebase['userid'];
    username = fromfirebase['username'];
    userimage = fromfirebase['userimage'];
    commentText = fromfirebase['commentText'];
  }

  Map<String, dynamic> tofirebase() {
    return {
      'postid': postid,
      'userid': userid,
      'username': username,
      'userimage': userimage,
      'commentText': commentText,
    };
  }
}
