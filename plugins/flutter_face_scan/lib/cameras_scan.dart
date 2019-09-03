import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'face_scan_controller.dart';
import 'flutter_face_scan.dart';
import 'my_clipper.dart';

typedef FaceScanCallBack = void Function(String path);

class CameraScan extends StatefulWidget {
  CameraDescription cameraDescription;
  String path;
  FaceScanCallBack faceScanCallBack;

  CameraScan(this.cameraDescription, this.path, this.faceScanCallBack,
      {Key key})
      : super(key: key);

  @override
  _CameraScanState createState() => _CameraScanState();
}

class _CameraScanState extends State<CameraScan> {
  CameraController controller;

  FaceScanValue faceScanValue = FaceScanValue();

  Timer timer;

  VoidCallback voidCallback;

  String showText = "检测中...";

  @override
  void initState() {
    controller =
        CameraController(widget.cameraDescription, ResolutionPreset.high);
    controller.initialize().then((_) {
      setState(() {});
    });
    FaceScan.controller.addListener(() {
      print("捕获值变化inIng的值为：" + FaceScan.controller.value.isIng.toString());
      setState(() {});
    });

    timer = Timer.periodic(Duration(milliseconds: 2000), (_) {
      takePhoto();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("人脸识别"),
        ),
        body: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(100)),
                    child: controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: CameraPreview(controller),
                          )
                        : Container(),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 34.5),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: FaceScan.controller.value.isIng
                          ? Color.fromARGB(100, 76, 144, 254)
                          : Colors.transparent,
                      border: FaceScan.controller.value.isIng
                          ? null
                          : Border.all(
                              width: 0, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(100)),
                  child: FaceScan.controller.value.isIng
                      ? Stack(
                          children: <Widget>[
                            Container(
                              height: 200,
                              width: 200,
                              child: CircularProgressIndicator(),
                            ),
                            Center(
                              child: Text(
                                "识别中...",
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor),
                              ),
                            )
                          ],
                        )
                      : Text(""),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 250),
                      child: Text(
                        FaceScan.controller.value.isIng
                            ? "检测中"
                            : FaceScan.controller.value.isFail
                                ? "验证失败，正在重新识别"
                                : "",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Image.asset(
                        "img/icon_up_phone.png",
                        width: 100,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text("请抬起手机，面向屏幕"),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void takePhoto() async {
    if (FaceScan.controller.value.isIng) {
      return;
    }
    File file = File(widget.path);
    if (file.existsSync()) {
      file.delete();
    }
    await controller.takePicture(widget.path);
    widget.faceScanCallBack(widget.path);
  }
}
