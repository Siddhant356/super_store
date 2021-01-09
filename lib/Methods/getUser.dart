import 'dart:convert';

import 'package:http/http.dart';
import 'package:super_store/Methods/sharedPrefrences.dart';

class GetUser {
  final String url;
  GetUser(this.url);
  fetchUserDetails() async {
    final token = await getToken();
    final response = await get(Uri.encodeFull(url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      return res;
    } else {
      throw Exception("Failed to get post");
    }
  }
}
