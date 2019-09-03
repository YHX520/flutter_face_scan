library flutter_face_scan;

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'cameras_scan.dart';
import 'face_scan_controller.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

List<CameraDescription> cameras;

class FaceScan {
  static FaceScanController controller;
  static String filePath;
  static FaceScanValue faceScanValue;

  static init() async {
    try {
      cameras = await availableCameras();
      faceScanValue =
          FaceScanValue(isIng: false, isFail: false, isSuccess: false);
      controller = FaceScanController(faceScanValue);
      Directory tempDir = await getTemporaryDirectory();
      filePath = tempDir.path + "/temp.jpg";
      print(filePath);
      return true;
    } on CameraException catch (e) {
      print(e);
      return false;
    }
  }

  static openScan(
      {@required BuildContext context,
      @required String path,
      @required FaceScanCallBack faceScanCallBack}) {
    if (path == null) {
      path = filePath;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraScan(cameras[1], path, faceScanCallBack)));
  }

  static Scaning() {
    controller.value =
        FaceScanValue(isFail: false, isSuccess: false, isIng: true);
  }

  static ScanFail() {
    controller.value =
        FaceScanValue(isFail: true, isSuccess: false, isIng: false);
  }

  static reScan() {
    controller.value =
        FaceScanValue(isSuccess: false, isFail: false, isIng: false);
  }
}
