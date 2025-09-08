import 'package:flutter/material.dart';
import 'buttons.dart';
import 'tracking_controller.dart';
import 'package:simple_pip_mode/simple_pip.dart';
import 'pip_view.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(child: Text("Hier kommen deine Einstellungen hin")),
    );
  }
}
