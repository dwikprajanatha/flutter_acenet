import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/model/SPKModel.dart';
import 'package:acenet_project/models/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:acenet_project/drawer/drawer_layout.dart';
import 'home_page.dart';


class TodayTaskPage extends StatefulWidget {
  @override
  _TodayTaskPageState createState() => _TodayTaskPageState();
}

class _TodayTaskPageState extends State<TodayTaskPage> {
  List list = new List<SpkDetail>();
  var loading = true;

  _getSPK() async {
    // list.clear();

    await ApiServices().getSPK().then((value) {
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
      appBar: AppBar(title: Text("Today Schedule")),
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
              return CardLayout(
                pekerjaan: data.ket_pekerjaan,
                waktu: data.jam_mulai,
                pelanggan: data.nama,
                idPekerjaan: (data.id),
              );
            },
          ),
        ) : Center(
          child: Text("No Task for Today."),
        ),
      ),
    );
  }
}
