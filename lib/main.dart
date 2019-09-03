import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_face_scan/flutter_face_scan.dart';

void main() {
  runApp(MyApp());

  ///初始化
  FaceScan.init();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                FaceScan.openScan(
                    context: context,
                    path: null,
                    faceScanCallBack: (path) {
                      print("返回图片文件路径：" + path);
                    });

                Timer(Duration(milliseconds: 5000), () {
                  ///通知图形界面在识别中
                  FaceScan.Scaning();
                });

                Timer(Duration(milliseconds: 10000), () {
                  ///通知图形界面识别失败
                  FaceScan.ScanFail();
                });

                Timer(Duration(milliseconds: 20000), () {
                  ///识别成功后可关闭
                  Navigator.pop(context);
                });
              },
              child: Text("开始识别"),
            )
          ],
        ),
      ),
    );
  }
}
