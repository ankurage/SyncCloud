import 'package:flutter/material.dart';
import 'package:SyncCloud/widgets/background_widget.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundWidget(
          childrens: [
            Align(
              alignment: .topLeft,
              child: BackScreenIconWidget()
            )
          ],
        ),
      ),
    );
  }
}