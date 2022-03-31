import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/CasheHelper.dart';

import 'package:socialapp/Reusable.dart';
import 'package:socialapp/Screens/SignUp.dart';
import 'package:socialapp/Screens/SocialLayOut.dart';
import 'package:socialapp/States/LoginStates.dart';

import '../LoginCubit.dart';

class LogIn extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LoginCubit? loginCubit;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginSatets>(
        listener: (context, State) {
          if (State is LoginsucessState) {
            CasheHlper.saveDate(State.userid);
            print(State.userid);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SocialLayOut()));
          }
          if (State is LoginErrorState) {
            Fluttertoast.showToast(
                msg: "Uncorrect E-mail or password",
                //toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2);
          }
        },
        builder: (context, State) {
          loginCubit = BlocProvider.of<LoginCubit>(context);
          return Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Logo(context),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //  crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: width * .7,
                                  child: TextFormField(
                                    controller: email,
                                    decoration: InputDecoration(
                                        label: const Text("E-mail"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "You Must Enter Your E-mail";
                                      } else {
                                        return null;
                                      }
                                    },
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                  width: width * .7,
                                  child: TextFormField(
                                    controller: password,
                                    decoration: InputDecoration(
                                        label: const Text("password"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "You Must Enter Your password";
                                      } else {
                                        return null;
                                      }
                                    },
                                  )),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "ForgetPassword?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUp()));
                                      },
                                      child: const Text("SignUp",
                                          style:
                                              TextStyle(color: Colors.white)))
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                width: width * .3,
                                child: RaisedButton(
                                  child: Text(
                                    "LogIn",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      loginCubit!.Login(
                                          email: email.text,
                                          password: password.text);
                                    }
                                  },
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
