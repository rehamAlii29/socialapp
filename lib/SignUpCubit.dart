import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:socialapp/States/SigupStates.dart';
import 'package:socialapp/UseModel.dart';

class SignUpCubit extends Cubit<SignUpSatets> {
  SignUpCubit() : super(SignUpIntialState());
  static SignUpCubit get(context) => BlocProvider.of<SignUpCubit>(context);

  void Register({
    @required String? email,
    @required String? password,
    @required String? name,
    @required String? phone,
  }) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      createUser(
          mail: email, name: name, phone: phone, userId: value.user!.uid);

      //  emit(SignUpsucessState());
    }).catchError((onError) {
      emit(SignUpErrorState(onError.toString()));
    });
  }

  createUser({
    @required String? mail,
    @required String? name,
    @required String? phone,
    @required String? userId,
  }) {
    UserModel? userModel = UserModel(
        email: mail,
        name: name,
        phone: phone,
        userId: userId,
        cover:
            "https://img.freepik.com/free-photo/interior-wall-mockup-with-green-plantgreen-wall-shelf3d-rendering_41470-4431.jpg?t=st=1647292147~exp=1647292747~hmac=d25cefbc7561fa85baa8b643e15f0300762b7b313a6e40b9cd7227c3a7b9ef83&w=826",
        image:
            "https://www.kindpng.com/picc/m/620-6203229_whatsapp-profile-picture-icon-png-download-instagram-profile.png",
        bio: "What about You... ");

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .set(userModel.toFireBase())
        .then((value) {
      emit(CreateUsersucessState());
    }).catchError((onError) {
      emit(CreateUserErrorState(onError));
      print(onError);
    });
  }
}
