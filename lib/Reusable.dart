import 'package:flutter/material.dart';

Widget Logo(context) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.only(top: 120),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 240,
      child: Stack(
        children: <Widget>[
          Positioned(
              child: SizedBox(
            child: Align(
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                width: 150,
                height: 150,
              ),
              alignment: Alignment.center,
            ),
            height: 154,
          )),
          Positioned(
            child: SizedBox(
                height: 154,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Kallemny",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )),
          ),
          Positioned(
            width: 60,
            height: 60,
            top: 140,
            left: 260,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
          ),
          Positioned(
            width: 30,
            height: 30,
            top: 200,
            left: 230,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  ));
}

//
Widget defaultAppBar(
  @required BuildContext context,
  Widget? title,
  List<Widget>? actions,
) =>
    AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_left_outlined),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: title,
      actions: actions,
    );
