import 'package:acenet_project/API/ApiServices.dart';
import 'package:acenet_project/drawer/drawer_layout.dart';
import 'package:acenet_project/model/SPKModel.dart';
import 'package:acenet_project/models/index.dart';
import 'package:acenet_project/views/signature_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class FormSPK extends StatefulWidget {
  int idPekerjaan;

  FormSPK({@required this.idPekerjaan});

  @override
  _FormSPKState createState() => _FormSPKState();
}

class _FormSPKState extends State<FormSPK> {
  var _keteranganController = new TextEditingController();
  var _downloadController = new TextEditingController();
  var _uploadController = new TextEditingController();
  SharedPreferences sp;
  var data = null;
  var dataTeknisi = null;
  var id_teknisi;

  Map<String,dynamic> body = {
    'keterangan': null,
  };
  SpkDetail spk = new SpkDetail();
  File item;
  Image img;
  var loading = true;
  var upload = false;

  _getDetailSPK(int idPekerjaan) async {
    sp = await SharedPreferences.getInstance();
    id_teknisi = sp.get("USER_ID");
    await ApiServices().getDetailSPK(idPekerjaan).then((value) {
      setState(() {
        spk = value.data;
        loading = false;
        if(spk.status.toString() == "1")
          _keteranganController.text = spk.ket_lanjutan;
        if(spk.download_speed != null)
          _downloadController.text = spk.download_speed.toString();
        if(spk.upload_speed != null)
          _uploadController.text = spk.upload_speed.toString();
      });
    });
  }

  _submitSPK() async {
    sp = await SharedPreferences.getInstance();
    id_teknisi = sp.get("USER_ID");
    upload = true;
    await ApiServices().submitSPK(body).then((value) {
      setState(() {
        upload = false;
        loading = true;
        _getDetailSPK(widget.idPekerjaan);
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
                      initialValue: spk.teknisi[0].nama,
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
                        controller: _keteranganController,
                        maxLines: null,
                        enabled: spk.status == "1" ? false : true,
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
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100.0),
                      child: TextFormField(
                        controller: _downloadController,
                        maxLines: null,
                        keyboardType: TextInputType.number,
                        enabled: spk.status == "1" ? false : true,
                        decoration: InputDecoration(
                          labelText: "Download Data (Mb)",
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
                        controller: _uploadController,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        enabled: spk.status == "1" ? false : true,
                        decoration: InputDecoration(
                          labelText: "Upload Data (Mb)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  spk.status.toString() == "1" ? Container():
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: Text(
                        "Tanda Tangan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0),
                      )),
                  spk.status.toString() == "1" ? Container():
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              Text("Customer"),
                              Container(
                                width: double.infinity,
                                child: data == null
                                    ? Padding(
                                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
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
                                      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
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
                              ),
                            ],
                          )
                      ),
                      Expanded(
                          child: Column(
                            children: [
                              Text("Teknisi"),
                              Container(
                                width: double.infinity,
                                child: dataTeknisi == null
                                    ? Padding(
                                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                                  child: new MaterialButton(
                                    height: 40.0,
                                    minWidth: 20.0,
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    child: new Text("Sign Here"),
                                    onPressed: () => signTeknisi(context),
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
                                            child: Image.memory(dataTeknisi),
                                          ),
                                        ]),
                                    Container(
                                      margin: EdgeInsets.only(top: 16),
                                      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width - 32,
                                        child: new MaterialButton(
                                          height: 40.0,
                                          minWidth: 20.0,
                                          color: Theme.of(context).primaryColor,
                                          textColor: Colors.white,
                                          child: new Text("Change Sign"),
                                          onPressed: () => signTeknisi(context),
                                          splashColor: Colors.redAccent,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                  spk.status.toString() == "1" ? Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child: new MaterialButton(
                      height: 40.0,
                      minWidth: 20.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: new Text("Kembali"),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.redAccent,
                    ),
                  ):
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
                    child: new MaterialButton(
                      height: 40.0,
                      minWidth: 20.0,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: new Text("Simpan"),
                      onPressed: () async {
                        body['keterangan'] = _keteranganController.text == "" ? null : _keteranganController.text;
                        body['upload_data'] = _uploadController.text == "" ? null : _uploadController.text ;
                        body['download_data'] = _downloadController.text == "" ? null : _downloadController.text;
                        body['id_spk'] = widget.idPekerjaan;
                        body['signCustomer'] = data == null ? null : data;
                        body['signTeknisi'] = dataTeknisi == null ? null : dataTeknisi;

                        await _submitSPK();
                      },
                      splashColor: Colors.redAccent,
                    ),
                  )

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

  Future signTeknisi(context) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignaturePage()));

    //UBAH VARIABEL NYA
    setState(() {
      dataTeknisi = result;
      item = File.fromRawPath(data);
    });
  }
}
