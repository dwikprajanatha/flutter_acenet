import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/drawer/drawer_layout.dart';
import 'package:acenet_project/models/index.dart';
import 'package:acenet_project/views/upcoming_page.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var loading = true;
  JobDoneCount jobCount = JobDoneCount();
  List list = new List<SpkDetail>();
  _getJobCount() async {
    // list.clear();

    await ApiServices().getJobCounting().then((value) {
      setState(() {
        jobCount = value;
        loading = false;
      });
    });
  }

  _getJobDone() async {
    // list.clear();

    await ApiServices().getJobDone().then((value) {
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

    _getJobCount();
    _getJobDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Report")),
      drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await _getJobCount();
            await _getJobDone();

          },
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
                  Flexible(fit: FlexFit.tight, child: JobCountCard("This Week", jobCount != null ? jobCount.weekly_count : 0)),
                  Flexible(fit: FlexFit.tight, child: JobCountCard("This Month",jobCount != null ? jobCount.monthly_count : 0)),
                ],
              ),
              // TODAY TASK //
              Padding(
                padding: EdgeInsets.fromLTRB(5.0, 15.0, 0, 10.0),
                child: Text(
                  "Completed Task",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
              ),
              loading
                  ? Center(child: CircularProgressIndicator())
                  : list.length > 0 ?
              Column(
                children: list.map((data){
                  return UpcomingCardLayout(
                    pekerjaan: data.ket_pekerjaan,
                    waktu: data.tgl_pekerjaan+" "+data.jam_mulai,
                    pelanggan: data.nama,
                    idPekerjaan: (data.id),
                  );
                }).toList(),
              ): Center(
                child: Text("No Completed."),
              ),
            ],
          ),
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
  String label = "";
  int count = 0;
  JobCountCard(this.label,this.count);
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
            Text(count != null && count != "null" ? count.toString() : "-",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500)),
            Text(label,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}
