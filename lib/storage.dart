import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static late SharedPreferences sharedPreferences;
  static Future<void> initStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
