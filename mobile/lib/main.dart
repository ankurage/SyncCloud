import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'backgroundService/service.dart';
import 'provider/config_provider.dart';
import 'screens/screens.dart';

Future<void> initializeService(ConfigProvider configProv) async {
  final service = FlutterBackgroundService();
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    }
  );
  
  await service.configure(
    iosConfiguration: IosConfiguration(
      autoStart: configProv.autoStart,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(
      autoStart: configProv.autoStart,
      onStart: onStart,
      isForegroundMode: true,
      autoStartOnBoot: configProv.autoStart,
    ),
  );

  service.on("getClipboard").listen((event) async {
    final clip = await Clipboard.getData(Clipboard.kTextPlain);
    service.invoke("clipboardResult", {
      "text": clip?.text ?? "",
      "receiverIp": configProv.ip,
      "portSync": configProv.port
    });
  });

  // service.startService();
}

Future DatabaseInit(ConfigProvider config) async {
  await Hive.initFlutter();
  if (await config.boxIsEmpty()) {
    config.boxPutAll({
      "receiverIp": "192.168.1.1",
      "portSync": 5000,
      "autoStart": false
    });
  }
  var data = await config.boxGetAll();
  print(data);
  config.set(
    data["receiverIp"] ?? "192.168.1.1",
    data["portSync"] ?? 5000,
    data["autoStart"] ?? false
  );
}

void main() async {
  final config = ConfigProvider();

  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await DatabaseInit(config);
  await initializeService(config);
  await startServer(config);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => config
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SyncCloud",
      theme: ThemeData(
        colorSchemeSeed: Colors.green[500],
        brightness: Brightness.dark,
        appBarTheme: AppBarThemeData(
        ),
        scaffoldBackgroundColor: const Color.fromARGB(133, 60, 83, 51),
      ),
      routes: {
        "/": (context) => MainScreen(),
        "/config": (context) => ConfigScreen(),
        "/debug":(context) => DebugScreen()
      },
    );
  }
}
