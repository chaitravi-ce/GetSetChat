import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{

  static String userLoggedInKey = 'IsLoggedIn';
  static String usernameKey = 'username';
  static String emailKey = 'email';

  static Future<void> isUserLoggedIn(bool isUserLoggedIn)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUserName(String username)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(usernameKey, username);
  }

  static Future<void> saveUserEmail(String email)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(emailKey, email);
  }

  static Future<bool> getUserLoggedIn()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }

  static Future<String> getUserName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernameKey);
  }

  static Future<String> getUserEmail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }
}