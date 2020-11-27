import 'package:flutter/material.dart';
import 'package:acenet_project/drawer/drawer_layout.dart';
import 'home_page.dart';

class UpcomingTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upcoming Task")),
      drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            // TODAY TASK //
            CardLayout(
              pekerjaan: "Balabala",
              waktu: "1 April 2020 09.00",
              pelanggan: "Mr. Dony",
              idPekerjaan: 1,
            ),
            CardLayout(
              pekerjaan: "Balabala",
              waktu: "1 April 2020 09.00",
              pelanggan: "Mr. Dony",
              idPekerjaan: 2,
            ),
          ],
        ),
      ),
    );
  }
}
