import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHlper {
  static SharedPreferences? cashe;
  static init() async {
    cashe = await SharedPreferences.getInstance();
  }

  static Future<bool> saveDate(@required String? userId) async {
    return await cashe!.setString('userId', userId!);
  }

  static getData({@required String? key}) {
    return cashe!.get(key!);
  }
}
