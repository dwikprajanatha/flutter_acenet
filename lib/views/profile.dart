import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/models/index.dart';
import 'package:acenet_project/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:acenet_project/drawer/drawer_layout.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var nama = "-";
  var email = "-";
  var telp = "-";
  var loading = true;
  SharedPreferences sharedPreferences;
  User user = null;
  _getSPK() async {
    // list.clear();

    await ApiServices().getProfile().then((value) {
      setState(() {
        user = value;
        nama = user.nama == null ? user.username : user.nama;
        email = user.email;
        telp = user.no_telp;
        loading = false;
      });
    });
  }

  _logout() async {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("API_KEY", null);
      sharedPreferences.setString("USER_ID", null);
      sharedPreferences.setString("USER_NAME", null);
      Navigator.of(context)
          .pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen()), (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("test");
    _getSPK();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : user != null ? RefreshIndicator(
          onRefresh: () async {
            await _getSPK();
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15,),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.network("https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/default-avatar.png"),
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12
                      )
                    )
                  ),
                  child: Text(nama),
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black12
                          )
                      )
                  ),
                  child: Text(email),
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black12
                          )
                      )
                  ),
                  child: Text(telp),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      height: 40.0,
                      minWidth: 20.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: new Text("Log Out"),
                      onPressed: () async {
                        _logout();
                      },
                      splashColor: Colors.redAccent,
                    ),
                  ),
                )
              ],
            ),
          ),
        ) : Center(
          child: Text("No Upcoming Task."),
        ),
      ),
    );
  }
}
