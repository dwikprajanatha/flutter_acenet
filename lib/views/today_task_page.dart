import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/model/SPKModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:acenet_project/drawer/drawer_layout.dart';
import 'home_page.dart';

// class TodayTaskPage extends StatelessWidget {
//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Today Task")),
//       drawer: myDrawer(),
//       body: Container(
//         margin: EdgeInsets.all(10.0),
//         child: ListView(
//           children: <Widget>[
//             // TODAY TASK //
//             CardLayout(
//               pekerjaan: "Balabala",
//               waktu: "1 April 2020 09.00",
//               pelanggan: "Mr. Bobby",
//               idPekerjaan: 1,
//             ),
//             CardLayout(
//               pekerjaan: "Balabala",
//               waktu: "1 April 2020 09.00",
//               pelanggan: "Mr. Bobby",
//               idPekerjaan: 2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TodayTaskPage extends StatefulWidget {
  @override
  _TodayTaskPageState createState() => _TodayTaskPageState();
}

class _TodayTaskPageState extends State<TodayTaskPage> {
  List list = new List<SPKModel>();
  var loading = true;

  _getSPK(int idTeknisi) async {
    // list.clear();

    await ApiServices().getSPK(idTeknisi).then((value) {
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
    _getSPK(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Today Task")),
      drawer: myDrawer(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  var data = list[i];
                  return CardLayout(
                    pekerjaan: data.ket_pekerjaan,
                    waktu: data.jam_mulai,
                    pelanggan: data.nama,
                    idPekerjaan: int.parse(data.id),
                  );
                },
              ),
      ),
    );
  }
}
