import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:super_store/Methods/sharedPrefrences.dart';
import 'package:super_store/Utils/util.dart';
import 'package:super_store/View/dashboard.dart';
import 'package:super_store/View/signup.dart';
import 'package:validate/validate.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  var _hidePass = true;
  var _isloading = false;
  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }


  Future<void> submit(BuildContext context) async {

    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isloading = true;
      });
      final String url = "https://flutter-mongo-app.herokuapp.com/authenticate";
      Map data = {
        "email": _email.text,
        "password": _pass.text,
      };
      var body = json.encode(data);
      final http.Response response = await http.post(
        url,
        body: body,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      setState(() {
        _isloading = false;
      });
      var res = json.decode(response.body);
      print(res);
      if (response.statusCode != 200) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(res['msg']),
        ));
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Dashboard()), (route) => false);
        setToken(res['token']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [secondaryColor, primaryColor]),
            ),
          ),
          Positioned(
            top: size.height / 8,
            left: size.width / 3 - 10,
            child: Text(
              'Super Store',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              height: size.height * 2 / 3,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: textColor1),
                  ),
                  Form(
                    key: this._formKey,
                    child: Expanded(
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                              style: TextStyle(
                                  color: textColor1,
                                  fontWeight: FontWeight.bold),
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              validator: this._validateEmail,
                              decoration: new InputDecoration(
                                hintText: 'Email',
                              )),
                          TextFormField(
                              style: TextStyle(
                                  color: textColor1,
                                  fontWeight: FontWeight.bold),
                              controller: _pass,
                              obscureText: _hidePass,
                              decoration: new InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye_outlined),
                                  onPressed: () {
                                    setState(() {
                                      _hidePass = !_hidePass;
                                    });
                                  },
                                ),
                                hintText: 'Password',
                              )),
                          Builder(
                            builder:(context)=> Container(
                              margin: EdgeInsets.symmetric(vertical: 30),
                              height: 50,
                              child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () {
                                  if(!_isloading)
                                    submit(context);
                                },
                                icon:Icon(
                                  Icons.login,
                                  color: secondaryColor,
                                ),
                                label: _isloading?CircularProgressIndicator():Text(
                                  "Login",
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                color: primaryColor,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => SignUp()));
                            },
                            child: Text("Don't have account? Signup"),
                            textColor: secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
