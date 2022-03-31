import 'package:flutter/cupertino.dart';

class UserModel {
  String? email;
  String? bio;
  String? image;
  String? name;
  String? phone;
  String? userId;
  String? cover;
  bool? Emailverofied = false;
  UserModel(
      {@required this.email,
      @required this.name,
      @required this.phone,
      @required this.userId,
      @required this.image,
      @required this.bio,
      @required this.cover});
  UserModel.FromFirebase(Map<String, dynamic> fromfirebase) {
    email = fromfirebase["email"];
    name = fromfirebase['name'];
    phone = fromfirebase['phone'];
    userId = fromfirebase['userId'];
    bio = fromfirebase['bio'];
    image = fromfirebase['image'];
    cover = fromfirebase['cover'];
  }
  Map<String, dynamic> toFireBase() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'userId': userId,
      'bio': bio,
      'image': image,
      'cover': cover
    };
  }
}
