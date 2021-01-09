import 'dart:convert';

import 'package:http/http.dart';
import 'package:super_store/Models/sample.dart';

class Network {
  final String url;
  static List<Sample> sampleProduct = new List<Sample>();

  Network(this.url);
  Future<List<Sample>> loadResults() async {
    final response = await get(
      Uri.encodeFull(url),
    );
    if (response.statusCode == 200) {
      sampleProduct = loadSample(response.body);
      print(sampleProduct.length);
      return sampleProduct;
    } else {
      print("Failed to get Post -> ${response.body.toString()}");
    }
  }

  static List<Sample> loadSample(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Sample>((json) => Sample.fromJson(json)).toList();
  }
}
