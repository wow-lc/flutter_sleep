import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryManger extends StatefulWidget {
  static const routeName = "/batteryManger";
  @override
  State<StatefulWidget> createState() {
    return BatteryMangerState();
  }
}

class BatteryMangerState extends State<BatteryManger> {
  static final platform = const MethodChannel('sleep.flutter.io/battery');
  String _batteryLevel = "未知电量";
  Future<Null> _getBatteryLevel() async {
    String batteryLevel;

    try {
      final int result = await platform.invokeMethod("getBatteryLevel");
      batteryLevel = "当前电量为: $result %";
    } catch (e) {
      batteryLevel = "获取电量失败 /(ㄒoㄒ)/~~";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("电量管理")),
      body: Center(
          child: Column(
        children: [
          RaisedButton(
            onPressed: _getBatteryLevel,
            child: Text("获取电量"),
          ),
          Text(_batteryLevel),
        ],
      )),
    );
  }
}
