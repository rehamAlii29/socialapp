import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Screens/SocialLayOut.dart';

import 'package:socialapp/States/SigupStates.dart';

import '../SignUpCubit.dart';

class SignUp extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();
  SignUpCubit? signUpCubit = SignUpCubit();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
        create: ((context) => SignUpCubit()),
        child: BlocConsumer<SignUpCubit, SignUpSatets>(
          listener: ((context, state) {
            if (state is SignUpsucessState) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SocialLayOut()));
            }
          }),
          builder: (context, State) {
            signUpCubit = BlocProvider.of<SignUpCubit>(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your E-mail";
                              } else {
                                return null;
                              }
                            },
                            controller: email,
                            decoration: const InputDecoration(
                                label: Text("E-mail"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your Password";
                              } else {
                                return null;
                              }
                            },
                            controller: password,
                            decoration: const InputDecoration(
                                label: Text("Password"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your Name";
                              } else {
                                return null;
                              }
                            },
                            controller: name,
                            decoration: const InputDecoration(
                                label: Text("Name"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your Phone";
                              } else {
                                return null;
                              }
                            },
                            controller: phone,
                            decoration: const InputDecoration(
                                label: Text("Phone"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MaterialButton(
                          minWidth: width * .5,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              signUpCubit!.Register(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  phone: phone.text);
                            }
                          },
                          child: const Text("SignUp"),
                        )
                      ]),
                ),
              ),
            );
          },
        ));
  }
}
 
/*
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();
  SignUpCubit? signUpCubit = SignUpCubit();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
        create: ((context) => SignUpCubit()),
        child: BlocConsumer<SignUpCubit, SignUpSatets>(
          listener: ((context, state) {}),
          builder: (context, State) {
            signUpCubit = BlocProvider.of<SignUpCubit>(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              body: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your E-mail";
                              } else {
                                return null;
                              }
                            },
                            controller: email,
                            decoration: const InputDecoration(
                                label: Text("E-mail"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your Password";
                              } else {
                                return null;
                              }
                            },
                            controller: password,
                            decoration: const InputDecoration(
                                label: Text("Password"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your Name";
                              } else {
                                return null;
                              }
                            },
                            controller: name,
                            decoration: const InputDecoration(
                                label: Text("Name"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width * .7,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Must enter Your Phone";
                              } else {
                                return null;
                              }
                            },
                            controller: phone,
                            decoration: const InputDecoration(
                                label: Text("Phone"),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        MaterialButton(
                          minWidth: width * .5,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              signUpCubit!.Register(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  phone: phone.text);
                            }
                          },
                          child: const Text("SignUp"),
                        )
                      ]),
                ),
              ),
            );
          },
        ));
  }
}*/
