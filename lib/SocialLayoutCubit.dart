// ignore_for_file: non_constant_identifier_names, unnecessary_cast

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Const.dart';
import 'package:socialapp/Screens/Chats.dart';
import 'package:socialapp/Screens/Feeds.dart';
import 'package:socialapp/Screens/Post.dart';

import 'package:socialapp/Screens/Settings.dart';
import 'package:socialapp/Screens/Users.dart';

import 'package:socialapp/States/SocialLayoutState.dart';
import 'package:socialapp/UseModel.dart';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialapp/models/ChatModel.dart';
import 'package:socialapp/models/Commentmodel.dart';
import 'package:socialapp/models/PostModel.dart';

class SocialLayOutCubit extends Cubit<SocialLayOutStates> {
  SocialLayOutCubit() : super(SocialLayoutinitialState());
  static SocialLayOutCubit get(context) => BlocProvider.of(context);
  UserModel userModel = UserModel();
  UserModel? userdata = UserModel();
  getUserData() {
    emit(socialLayOutLoading());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .get()
        .then((value) {
      userdata = UserModel.FromFirebase(value.data() as Map<String, dynamic>);
      print(value.data());
      emit(socialLayOutSuccess());
    }).catchError((onError) {
      emit(socialLayOuterror(onError.toString()));
    });
  }

  List<Widget> Screens = [
    const Feeds(),
     Chats(),
    Post(),
    const Users(),
    AppSettings()
  ];
  List<String> titles = [
    "News Feed",
    "Chat",
    "Add Post",
    "Users",
    "App Setting"
  ];
// Bottom nav bar part
  int currentIndex = 0;
  changBottomNavBar(int index) {
    if (index == 2) {
      emit(AddNewPoststate());
    } else {
      currentIndex = index;
    }
    emit(changeNavigationbarstate());
    // هوا جاب getall users فى دوسة الاندكس
    //انا جبتها فى الbuild بتاعت الشات :D كل الطرق تؤدى الى روما
  }

// picking profile image
  final picker = ImagePicker();
  XFile? profile_image;
  File? profileImageFile;
  Future<void> getProfileImage() async {
    profile_image = await picker.pickImage(source: ImageSource.gallery);
    if (profile_image != null) {
      profileImageFile = File(profile_image!.path);
      emit(PickProfilePictureSuccess());
    } else {
      emit(PickProfilePictureError("no image selected"));
    }
  }

// picking cover image
  File? coverimageFile;
  XFile? coverimage;

  Future<void> getCoverimage() async {
    coverimage = await picker.pickImage(source: ImageSource.gallery);
    if (coverimage != null) {
      coverimageFile = File(coverimage!.path);
      emit(PickCoverPictureSuccess());
    } else {
      emit(PickCoverPictureError("No image selected"));
    }
  }

  void uploadProfilePhototofirebase({
    @required String? updatename,
    @required String? updatephone,
    @required String? updatebio,
  }) async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profile_image!.path).pathSegments.last}')
        .putFile(profileImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(uploadprofilephotosuccess());
        update(
            updatename: updatename,
            updatephone: updatephone,
            updatebio: updatebio,
            profile: value);
      });
    }).catchError((onError) {
      emit(uploadprofilephotoerror(onError));
    });
  }

  void uploadcoverPhototofirebase({
    @required String? updatename,
    @required String? updatephone,
    @required String? updatebio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(uploadcoverphotosuccess());
        update(
            updatename: updatename,
            updatephone: updatephone,
            updatebio: updatebio,
            cover: value);
      });
    }).catchError((onError) {
      emit(uploadcoverphotoerror(onError));
    });
  }

  void update(
      {@required String? updatename,
      @required String? updatephone,
      @required String? updatebio,
      String? cover,
      String? profile}) {
    emit(updateuserloading());

    UserModel? userModel = UserModel(
        name: updatename,
        phone: updatephone,
        bio: updatebio,
        image: profile ?? userdata!.image,
        cover: cover ?? userdata!.cover,
        email: userdata!.email,
        userId: userdata!.userId);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userdata!.userId)
        .update(userModel.toFireBase())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(userupdateerror(onError.toString()));
    });
  }

////// creating post
  XFile? imagePostFile;
  File? imagepost;
  Future<void> getpostimage() async {
    imagePostFile = await picker.pickImage(source: ImageSource.gallery);
    if (imagePostFile != null) {
      imagepost = File(imagePostFile!.path);
      emit(updatepostphotosuccess());
    }
  }

  void PostWithoutImage({
    @required String? PostText,
    @required String? posttime,
    String? postimage,
  }) {
    emit(createpostloading());
    PostModel postModel = PostModel(
      userId: userdata!.userId,
      name: userdata!.name,
      userimage: userdata!.image,
      postText: PostText,
      postTime: posttime,
      postImage: postimage ?? '',
    );
    FirebaseFirestore.instance
        .collection('Posts')
        .add(postModel.ToFirebase())
        .then((value) {
      emit(createpostsuccess());
    }).catchError((onError) {
      emit(createposterror(onError));
    });
  }

// post with image
  PostWithimage({@required String? Posttext, @required String? Posttime}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Posts/${Uri.file(imagePostFile!.path).pathSegments.last}')
        .putFile(imagepost!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        PostWithoutImage(
            PostText: Posttext, posttime: Posttime, postimage: value);
      });
      emit(updatepostphotosuccess());
    }).catchError((onError) {});
  }

// cancle post image
  canclePostImage() {
    imagepost = null;
    emit(Canclepostimagestate());
  }

  // get posts  at news feed
  List<PostModel> postAtNewwfeeds = [];
  List<String> postid = [];
  // list that save the posts id
  List<int> likes = [];
  List<int> commentslength = [];
  void getPostsAttnewfeeds() {
    emit(GetPostsAtNewFeedsLoading());
    FirebaseFirestore.instance.collection("Posts").get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('Likes').get().then((value) {
          likes.add(value.docs.length);
          postid.add(element.id);

          postAtNewwfeeds.add(
              PostModel.fromFirebase(element.data() as Map<String, dynamic>));
          element.reference.collection('Comments').get().then((value) {
            commentsid.add(element.id);
            commentslength.add(value.docs.length);
            commentslist.add(Commentmodel.fromFibrebase(
                element.data() as Map<String, dynamic>));
          });
        });
      }
      emit(GetPostsAtNewFeedsSuccess());
    }).catchError((onError) {
      emit(GetPostsAtNewFeedsError(onError.toString()));
    });
  }

  postLike(String Postid) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(Postid)
        .collection('Likes')
        .doc(userdata!.userId)
        .set({'likes': true}).then((value) {
      emit(PostLikesSuccessstate());
    }).catchError((onError) {
      emit(PostLikesErrorstate(onError.toString()));
    });
  }

// creating comments
//comment id
// ana mafrod ageb el comm id la2n kol comment mo5talef
// el comment id ha2by el key efl set
  Commentmodel? comments;
  List<String> commentsid = [];
  List<Commentmodel> commentslist = [];

  void writeComment({
    @required String? postid,
    @required String? commentText,
  }) {
    Commentmodel commentModel = Commentmodel(
        postid: postid,
        userid: userdata!.userId,
        username: userdata!.name,
        userimage: userdata!.image,
        commentText: commentText);
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postid)
        .collection('Comments')
        .add(commentModel.tofirebase())
        .then((value) {
      emit(PostCommentsSuccessstate());
    }).catchError((onError) {});
  }

  void getcomments(String postid) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postid)
        .collection('Comments')
        .get()
        .then((value) {
      for (var element in value.docs) {
        commentslist.add(
            Commentmodel.fromFibrebase(element.data() as Map<String, dynamic>));
      }
    });
  }
  List<UserModel> allusers=[];
  CollectionReference usercollection =FirebaseFirestore.instance.collection('Users');
getAllUsers()async {
 // allusers = [];


  await  FirebaseFirestore.instance.collection('Users').snapshots().listen((event) {
     allusers = [];
      for (var user in event.docs) {
        if (user.data()['userId']!=userdata!.userId) {

        allusers.add(UserModel.FromFirebase(user.data()));
      }}
    });


}//
sendMassege({
    String? reciverId,
  String?msaage,
  String?datetime

}){
  ChatModel chatModel = ChatModel(
    senderId: userdata!.userId ,
    reciverId: reciverId,
    dateTime: datetime,
    message: msaage
  );
  FirebaseFirestore.instance.collection('Users').doc(userdata!.userId).
  collection('Chats').doc(reciverId).collection('Massges').
  add(chatModel.tofirebase()).then((value) {
    emit(SendMassegesSuccess());
  });
  FirebaseFirestore.instance.collection('Users').doc(reciverId).
  collection('Chats').doc(userdata!.userId).collection('Massges').
  add(chatModel.tofirebase()).then((value) {
    emit(SendMassegesSuccess());
  });
}
List<ChatModel> masseges =[];
getMassages({String?recieverId}){
  FirebaseFirestore.instance.collection('Users').doc(userdata!.userId).
  collection('Chats').doc(recieverId).collection('Massges')
      .orderBy('dateTime').snapshots().listen((event) {
masseges = [];

        for(var masssege in event.docs)
          {
            masseges.add(ChatModel.fromFibrebase(masssege.data()));


          }
  });
  emit(GetMassegesSuccess());
}



}




