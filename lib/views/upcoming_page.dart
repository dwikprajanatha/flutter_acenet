import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/models/index.dart';
import 'package:flutter/material.dart';
import 'package:acenet_project/drawer/drawer_layout.dart';
import 'package:intl/intl.dart';
import 'home_page.dart';



class UpcomingTaskPage extends StatefulWidget {
  @override
  _UpcomingTaskPageState createState() => _UpcomingTaskPageState();
}

class _UpcomingTaskPageState extends State<UpcomingTaskPage> {
  List list = new List<SpkDetail>();
  var loading = true;

  _getSPK() async {
    // list.clear();

    await ApiServices().getUpcomingSPK().then((value) {
      setState(() {
        list = value;
        loading = false;
      });
    });
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
      appBar: AppBar(title: Text("Upcoming Task")),
      drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : list.length > 0 ? RefreshIndicator(
          onRefresh: () async {
            await _getSPK();
          },
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) {
              var data = list[i];
              return UpcomingCardLayout(
                pekerjaan: data.ket_pekerjaan,
                waktu: data.tgl_pekerjaan+" "+data.jam_mulai,
                pelanggan: data.nama,
                idPekerjaan: (data.id),
              );
            },
          ),
        ) : Center(
          child: Text("No Upcoming Task."),
        ),
      ),
    );
  }
}

class UpcomingCardLayout extends StatelessWidget {
  String waktu, pekerjaan, pelanggan;
  int idPekerjaan;

  UpcomingCardLayout(
      {@required this.waktu,
        @required this.pekerjaan,
        @required this.idPekerjaan,
        @required this.pelanggan});

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd HH:mm").parse(waktu);
    var date = DateFormat("dd MMM yyyy - HH:mm").format(tempDate);
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
                          Icons.calendar_today,
                          size: 25.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(date),
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