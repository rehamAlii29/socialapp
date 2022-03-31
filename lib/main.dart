import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/CasheHelper.dart';
import 'package:socialapp/Home.dart';
import 'package:socialapp/LoginCubit.dart';

import 'package:socialapp/Screens/SocialLayOut.dart';
import 'package:socialapp/SocialLayoutCubit.dart';
import 'package:socialapp/States/SocialLayoutState.dart';

import 'Const.dart';
import 'block_observer.dart';

void main() async {
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CasheHlper.init();
  Widget? widget;
  userId = CasheHlper.getData(key: 'userId');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    if (userId != null) {
      widget = SocialLayOut();
      // print(userid);
    } else {
      widget = Home();
    }
    runApp(SocialApp(
      Startwidget: widget!,
    ));
  });
  blocObserver:
  MyBlocObserver();
}

class SocialApp extends StatelessWidget {
  @required
  final Widget? Startwidget;
  const SocialApp({this.Startwidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) => SocialLayOutCubit()
                ..getUserData()
                ..getPostsAttnewfeeds()),
          BlocProvider(create: (BuildContext context) => LoginCubit()),
        ],
        child: BlocConsumer<SocialLayOutCubit, SocialLayOutStates>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                        titleTextStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold),
                        iconTheme: IconThemeData(color: Colors.black),
                        actionsIconTheme: IconThemeData(color: Colors.black)),
                    //  scaffoldBackgroundColor: const Color(0xFF80E1D1),
                    //  hintColor: const Color(0xFFC0F0E8),
                    //  primaryColor: const Color(0xFF80E1D1),
                    fontFamily: "Roboto",
                    textTheme: const TextTheme(
                        headline3: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        subtitle1: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black))),
                home: Startwidget,
              );
            },
            listener: (context, State) {}));
  }
}
