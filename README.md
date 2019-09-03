# flutter_face_scan_exmple


# android:无需配置
# ios:在Info.plist文件中加入
````html
<key>NSCameraUsageDescription</key>
	<string>需要您的确认才能访问相机</string>
````
# 使用

1.初始化
````dart
void main() {
  runApp(MyApp());

  ///初始化
  FaceScan.init();
}
````
2.打开扫描页面
````dart
 FaceScan.openScan(
  context: context,
  path: null,
  faceScanCallBack: (path) {
    print("返回图片文件路径：" + path);
  });
                    
````
3.改变扫描页面的一些调用
````dart
 ///通知图形界面在识别中
 FaceScan.Scaning();
 
 ///通知图形界面识别失败
 FaceScan.ScanFail();
 
 ///识别成功后可关闭页面
 Navigator.pop(context);
 
 
                  
````


A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
