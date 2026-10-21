import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:SyncCloud/screens/screens.dart';
import 'package:SyncCloud/widgets/background_widget.dart';
import 'package:provider/provider.dart';
import '../../widgets/widgets.dart';

import '../../provider/config_provider.dart';
import 'Widgets/widgets.dart';

class ConfigScreen extends StatefulWidget {
  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BackgroundWidget(
          childrens: [
            Align(
              alignment: .topLeft,
              child: BackScreenIconWidget(),
            ),

            Align(
              alignment:  Alignment(0, -0.6),
              child: Text(
                "Config",
                style: TextStyle(fontSize: 50),
              ),
            ),

            Align(
              alignment: .center,
              child: FirstSideWidget(),
            ),
            Align(
              alignment: .bottomCenter,
              child: SecondSideWidget(eraseData, saveConfig),
            ),
          ],
        )
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    var confProvider = context.read<ConfigProvider>();
    confProvider.receiverIpController.text = confProvider.ip;
    confProvider.portSyncController.text = confProvider.port.toString();
  }

  Future saveConfig() async {
    var confProvider = context.read<ConfigProvider>();

    var newSyncPort = int.parse(confProvider.portSyncController.text);
    var newReceiverIp = confProvider.receiverIpController.text;
    var newAutoStartValue = confProvider.autoStartController;

    confProvider.set(newReceiverIp, newSyncPort, newAutoStartValue);

    confProvider.boxPutAll({
      "receiverIp": newReceiverIp,
      "portSync": newSyncPort,
      "autoStart": newAutoStartValue
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Config Saved!"),
        behavior: .floating,
        margin: EdgeInsets.all(20),
      )
    );
  }

  Future eraseData() async {
    Future confirmDelete() async {
      var box = await Hive.openBox("cfg");
      await box.clear();
      exit(0);
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Erase data?"),
          content: Text("This action will delete all data, with no way to recover it"),
          actions: [
            ElevatedButton(
              // style: ElevatedButton.styleFrom(
              //   backgroundColor: Colors.red[700]
              // ),
              onPressed: () => Navigator.pop(context),
              child: Text("No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700]
              ),
              onPressed: () => confirmDelete(),
              child: Text("Yes"),
            )
          ],
        );
      },
    );
  }
}//---------------------------------------------

class SecondSideWidget extends StatelessWidget {
  final VoidCallback saveConfig;
  final VoidCallback eraseData;

  const SecondSideWidget(
    this.eraseData,
    this.saveConfig
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: IconButtonWidget(
                  effectColor: Colors.red,
                  buttonPadding: EdgeInsetsGeometry.symmetric(vertical: 10),
                  onPressed: eraseData,
                  child: Row(mainAxisAlignment: .center, children: [
                    Text("Erase all Data"),
                    Icon(Icons.delete)
                  ],),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButtonWidget(
                  buttonPadding: EdgeInsetsGeometry.symmetric(vertical: 20),
                  onPressed: saveConfig,
                  child: Row(mainAxisAlignment: .center, children: [
                    Text("Save"),
                    Icon(Icons.done)
                  ],),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class FirstSideWidget extends StatefulWidget {
  const FirstSideWidget({
    super.key,
  });

  @override
  State<FirstSideWidget> createState() => _FirstSideWidgetState();
}

class _FirstSideWidgetState extends State<FirstSideWidget> {
  bool autoStartValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var confProvider = context.read<ConfigProvider>();

    setState(() {
      autoStartValue = confProvider.autoStart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleTextFieldBackgroundWidget(
            childPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text("Auto Start Sync on Open"),
                Switch(
                  value: autoStartValue, onChanged: (v) => autoStartChange(v)
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: DoubleTextFieldBackgrounddWidget(
            fieldOne: Expanded(child: PortFieldWidget()),
            fieldTwo: Expanded(child: ReceiverIpFieldWidget()),
          ),
        ),
      ],
    );
  }

  Future autoStartChange(value) async {
    var confProvider = context.read<ConfigProvider>();
    confProvider.isAutoStartingController = value;
    setState(() {
      autoStartValue = confProvider.autoStartController;
    });
  }
}
