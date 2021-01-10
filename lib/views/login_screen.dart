import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/models/index.dart';
import 'package:acenet_project/models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  var usernameField = TextEditingController();
  var passwordField = TextEditingController();
  var fcmToken = null;
  Future loginMethod() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(usernameField.text);
    print(passwordField.text);
    User user = User();
    user.username = usernameField.text;
    user.password = passwordField.text;

    LoginResponse response = await ApiServices().login(user);
    print(response);
    if(response.success) {
      sp.setString("API_KEY", response.data.access_token);
      sp.setString("USER_ID", response.data.id.toString());
      sp.setString("USER_NAME", response.data.nama.toString());
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/dashboard', (Route<dynamic> route) => false);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseMessaging.getToken().then((String token) {
      fcmToken = token;
      print(fcmToken);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffFF512F),
                Color(0xffDD2476),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo-acenet.png',
                  height: 180.0,
                  width: 180.0,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0.1),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          height: 250.0,
                          width: 300.0,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 25.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 10.0,
                                ),
                                child: TextField(
                                  autocorrect: false,
                                  autofocus: false,
                                  style: TextStyle(fontSize: 20.0),
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Username",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(15.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey))),
                                  controller: usernameField,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: TextField(
                                  autocorrect: false,
                                  autofocus: false,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 20.0),
                                  controller: passwordField,

                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText: "Password",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(15.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: MaterialButton(
                                  onPressed: ()  async {
                                    await loginMethod();
                                  },
                                  minWidth: 40.0,
                                  splashColor: Colors.grey[300],
                                  color: Colors.grey,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 10.0),
                                  child: Text("Login",
                                      style: TextStyle(fontSize: 18.0)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
