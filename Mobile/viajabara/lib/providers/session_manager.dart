import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  static Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}