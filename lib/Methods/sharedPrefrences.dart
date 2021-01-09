import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


setToken(String value) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('token', value);
}

getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String token = preferences.getString('token');
  return token;
}


logOut() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  dynamic result;
  try {
    result = await preferences.clear();
    return result;
  } catch (e) {
    throw Exception('Problem in Signing Out.');
  }
}