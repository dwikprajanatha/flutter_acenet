import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5.0,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ListView(
        children: <Widget>[
          Signature(
            controller: _controller,
            height: MediaQuery.of(context).size.height - 50.0,
            backgroundColor: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
            child: new MaterialButton(
              height: 40.0,
              minWidth: 20.0,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: new Text("Selesai"),
              onPressed: () => testAc(_controller.toPngBytes()),
              splashColor: Colors.redAccent,
            ),
          )
        ],
      ),
    );
  }

  testAc(var points) {
    Navigator.pop(context, points);
  }
}
