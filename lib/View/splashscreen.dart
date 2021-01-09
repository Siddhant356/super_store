import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:super_store/Methods/sharedPrefrences.dart';
import 'package:super_store/Utils/util.dart';
import 'package:super_store/View/dashboard.dart';
import 'package:super_store/View/signup.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>{
  var token;
  @override
 initState(){
    super.initState();
    navigateHelper();
  }

  navigateHelper() async {
    token = await getToken();
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text(
            'Super Store',
            style: new TextStyle(fontWeight: FontWeight.bold,
                fontSize: 30.0, color: Colors.white),
          ),
      seconds: 3,
      navigateAfterSeconds: token!=null?Dashboard():SignUp(),
      gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [secondaryColor, primaryColor]
      ),
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Colors.white,
    );
  }
}
