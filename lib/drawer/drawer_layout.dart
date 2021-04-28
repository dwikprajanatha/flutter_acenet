import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myDrawer extends StatefulWidget {

  @override
  _myDrawerState createState() => _myDrawerState();

}

class _myDrawerState extends State<myDrawer> {
  String nama = "-";
  SharedPreferences sharedPreferences ;

  _getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      if (sharedPreferences.getString("USER_NAME") != null)
        nama = sharedPreferences.getString("USER_NAME");
    });

  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.red[800]),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/logo-acenet.png',
                            width: 70.0, height: 70.0),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Text(nama,
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  )
                ],
              ),
            ),
          ),
          CustomListTile(
              icon: Icons.dashboard, title: "Dashboard", onTap: "/dashboard"),
          CustomListTile(
              icon: Icons.work, title: "Today Schedule", onTap: "/today"),
          CustomListTile(
              icon: Icons.update, title: "Upcoming Schedule", onTap: "/upcoming"),
          CustomListTile(icon: Icons.web, title: "Report", onTap: "/history"),
          CustomListTile(
              icon: Icons.account_circle, title: "Profile", onTap: "/profile"),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  String title, onTap;
  IconData icon;

  CustomListTile(
      {@required this.icon, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]))),
            child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(onTap, arguments: 'bababababa'),
                splashColor: Colors.red[200],
                child: Container(
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(icon),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(title),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
