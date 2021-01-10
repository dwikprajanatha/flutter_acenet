
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {

  @override
  _SplashScreenPageState createState()=> _SplashScreenPageState();

}

class _SplashScreenPageState extends State<SplashScreenPage> {
  SharedPreferences sp;

  _getUser() async {
    sp = await SharedPreferences.getInstance();

    var token = sp.get("API_KEY");
    var id_teknisi = sp.get("USER_ID");

    if(token == null) {
        Navigator.pushReplacementNamed(context, "/login");
    } else {
      Navigator.pushReplacementNamed(context, "/dashboard");
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo-acenet.png',
          height: 180.0,
          width: 180.0,
        ),
      ),
    );
  }

}