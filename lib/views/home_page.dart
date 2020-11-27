import 'package:acenet_project/drawer/drawer_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            // JOB COUNT //
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 8.0),
              child: Text(
                "Job Count",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              children: [
                Flexible(fit: FlexFit.tight, child: JobCountCard()),
                Flexible(fit: FlexFit.tight, child: JobCountCard()),
              ],
            ),
            // TODAY TASK //
            Padding(
              padding: EdgeInsets.fromLTRB(5.0, 15.0, 0, 10.0),
              child: Text(
                "Today Task",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
            ),
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

class CardLayout extends StatelessWidget {
  String waktu, pekerjaan, pelanggan;
  int idPekerjaan;

  CardLayout(
      {@required this.waktu,
      @required this.pekerjaan,
      @required this.idPekerjaan,
      @required this.pelanggan});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed('/detailPekerjaan', arguments: idPekerjaan),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 25.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(waktu),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 2.0,
                    indent: 2.0,
                    endIndent: 2.0,
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.work,
                          size: 25.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              pekerjaan,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12,
                    thickness: 2.0,
                    indent: 2.0,
                    endIndent: 2.0,
                    height: 5.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 25.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              pelanggan,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobCountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(
              "Work Done",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            Text("10",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
