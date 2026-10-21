import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfigProvider with ChangeNotifier {
  String receiverIp = "192.168.1.1";
  int portSync = 5000;
  bool isAutoStarting = false;

  TextEditingController receiverIpController = TextEditingController();
  TextEditingController portSyncController = TextEditingController();
  bool isAutoStartingController = false;

  String get ip => receiverIp;
  int get port => portSync;
  bool get autoStart => isAutoStarting;
  bool get autoStartController => isAutoStartingController;

  void set(ip, port, [autoStartValue=false]) {
    receiverIp = ip;
    portSync = port;
    isAutoStarting = autoStartValue;
    notifyListeners();
  }

  Future<Map> boxGetAll() async {
    var box = await Hive.openBox("cfg");
    var data = await box.toMap();
    box.close();
    return data;
  }

  Future boxPutAll(Map newData) async {
    var box = await Hive.openBox("cfg");
    box.putAll(newData);
    box.close();
  }

  Future boxClear() async {
    var box = await Hive.openBox("cfg");
    box.clear();
    box.close();
  }

  Future boxPut(key, value) async {
    var box = await Hive.openBox("cfg");
    box.put(key, value);
    box.close();
  }

  Future boxGet(key) async {
    var box = await Hive.openBox("cfg");
    var data = box.get(key);
    box.close();
    return data;
  }

  Future boxDelete(key) async {
    var box = await Hive.openBox("cfg");
    box.delete(key);
    box.close();
  }

  Future<bool> boxIsEmpty() async {
    var box = await Hive.openBox("cfg");
    return box.isEmpty;
  }
  
}
