import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SyncCloud/provider/config_provider.dart';
import 'package:provider/provider.dart';

class ReceiverIpFieldWidget extends StatelessWidget {
  const ReceiverIpFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: .center,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9]"), replacementString: ".")
      ],
      controller: context
          .read<ConfigProvider>()
          .receiverIpController,
      decoration: InputDecoration(
        label: Row(
          mainAxisAlignment: .center,
          children: [
            Text("Receiver IP's"),
          ],
        ),
        border: InputBorder.none
      ),
    );
  }
}

class PortFieldWidget extends StatelessWidget {
  const PortFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      textAlign: TextAlign.center,
      controller: context
          .read<ConfigProvider>()
          .portSyncController,
      decoration: InputDecoration(
        label: Row(
          mainAxisAlignment: .center,
          children: [
            Text("Port"),
          ],
        ),
        border: InputBorder.none
      ),
    );
  }
}
