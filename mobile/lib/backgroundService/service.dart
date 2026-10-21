import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:SyncCloud/provider/config_provider.dart';

void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
}

//------------------
@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

//------------------
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  var oldClip = "";
  var port = 5000;

  if (service is AndroidServiceInstance) {
    service.on("setAsForeground").listen((event) {
      service.setAsForegroundService();
      
    });
    service.on("setAsBackground").listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on("stopService").listen((event) {
    service.stopSelf();
  });
  service.on("clipboardResult").listen((event) async {
    final text = event?["text"];
    port = event?["portSync"];

    if (oldClip == text) {return;}
    
    else {
      try {
        final socket = await Socket.connect(
            event?["receiverIp"], // IP ноутбука
            event?["portSync"],
          );

          socket.write(text);

          await socket.flush();
          await socket.close();
          oldClip = text;
          socket.close();
        } on SocketException catch (e) {
          print("Server unvaible: $e");
        }
      }
  });

  Timer.periodic(Duration(seconds: 1), (timer) async {
    service.invoke("getClipboard");
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(title: "Sync...", content: "Click for open");
      }
    }

    print("1");
    
  });
}

Future<void> startServer(ConfigProvider config) async {
  print(config.port);
  var server = await ServerSocket.bind(InternetAddress.anyIPv4, config.port);
  server.listen((Socket client) {
    print("server listening");
    client.listen((Uint8List bytes) async {
      var data = utf8.decode(bytes);
      print(data);
      await Clipboard.setData(ClipboardData(text: data));
      print("nice");
      client.close();
      data = "";
    });
  });
}
