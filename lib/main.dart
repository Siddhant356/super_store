import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_store/View/splashscreen.dart';

import 'Models/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Splashscreen(),
      ),
    );
  }
}
