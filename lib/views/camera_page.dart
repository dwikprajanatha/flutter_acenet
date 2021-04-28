import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  CameraController controller;

  Future<void> initializeCamera() async {
      var cameras = await availableCameras();

      controller = CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  Future<String> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String dirPath = '${root.path}/Camera';
    await Directory(dirPath).create(recursive: true);

    String picPath = '$dirPath/${DateTime.now()}.jpg';

    try{
      await controller.takePicture(picPath);
    } catch (e){
      return null;
    }

    return picPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a Picture')),
      body: FutureBuilder<void>(
        future: initializeCamera(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          if(!controller.value.isTakingPicture){
            String result = await takePicture();
            Navigator.pop(context, result);
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}

