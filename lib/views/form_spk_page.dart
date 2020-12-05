import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/drawer/drawer_layout.dart';
import 'package:acenet_project/model/SPKModel.dart';
import 'package:acenet_project/views/signature_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FormSPK extends StatefulWidget {
  int idPekerjaan;

  FormSPK({@required this.idPekerjaan});

  @override
  _FormSPKState createState() => _FormSPKState();
}

class _FormSPKState extends State<FormSPK> {
  // var _controller = new TextEditingController();

  var data = null;
  SPKModel spk = new SPKModel();
  File item;
  Image img;
  var loading = true;

  _getDetailSPK(int idPekerjaan) async {
    await ApiServices().getDetailSPK(idPekerjaan).then((value) {
      setState(() {
        spk = value;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getDetailSPK(widget.idPekerjaan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Surat Perintah Kerja Digital")),
      drawer: myDrawer(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 15.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: spk.no_spk,
                      decoration: InputDecoration(
                        labelText: "No. SPK",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: spk.ket_pekerjaan,
                      decoration: InputDecoration(
                        labelText: "Pekerjaan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: spk.ikr,
                      decoration: InputDecoration(
                        labelText: "Teknisi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: Text(
                        "Client Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0),
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: spk.nama,
                      decoration: InputDecoration(
                        labelText: "Nama Client",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      enabled: false,
                      initialValue: spk.jenis_layanan,
                      decoration: InputDecoration(
                        labelText: "Jenis Layanan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100.0),
                      child: TextFormField(
                        maxLines: null,
                        enabled: false,
                        initialValue: spk.alamat,
                        decoration: InputDecoration(
                          labelText: "Alamat",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100.0),
                      child: TextFormField(
                        maxLines: null,
                        enabled: true,
                        initialValue: spk.keterangan,
                        decoration: InputDecoration(
                          labelText: "Keterangan",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: Text(
                        "Tanda Tangan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0),
                      )),
                  data == null
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                          child: new MaterialButton(
                            height: 40.0,
                            minWidth: 20.0,
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: new Text("Sign Here"),
                            onPressed: () => testKirim(context),
                            splashColor: Colors.redAccent,
                          ),
                        )
                      : Column(
                        children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[
                              Container(
                                height: 80.0,
                                alignment: Alignment.center,
                                child: Image.memory(data),
                              ),
                            ]),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 32,
                              child: new MaterialButton(
                                height: 40.0,
                                minWidth: 20.0,
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: new Text("Change Sign"),
                                onPressed: () => testKirim(context),
                                splashColor: Colors.redAccent,
                              ),
                            ),
                          )
                        ],
                      ),
                ],
              ),
            ),
    );
  }

  Future testKirim(context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignaturePage()));

    //UBAH VARIABEL NYA
    setState(() {
      data = result;
      item = File.fromRawPath(data);
    });
  }
}
