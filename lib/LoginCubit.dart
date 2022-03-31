import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/States/LoginStates.dart';

class LoginCubit extends Cubit<LoginSatets> {
  LoginCubit() : super(LoginIntialState());
  static get(context) => BlocProvider.of(context);
  void Login({@required String? email, @required String? password}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      emit(LoginsucessState(value.user!.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }
}
