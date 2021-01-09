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

setCart(List cartItems) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cart-items',cartItems);
}

getCart() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  List cartItems = preferences.getStringList('cart-item');
  return cartItems;
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