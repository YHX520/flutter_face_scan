import 'package:flutter/material.dart';

class FaceScanController extends ValueNotifier<FaceScanValue> {
  FaceScanController(FaceScanValue value) : super(value);
}

class FaceScanValue {
  ///是否识别成功
  bool isSuccess = false;

  ///是否识别中
  bool isIng = false;

  ///是否识别失败
  bool isFail = false;

  FaceScanValue({this.isSuccess, this.isIng, this.isFail});
}
