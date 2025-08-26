import 'package:flutter/material.dart';
import 'buttons.dart';
import 'tracking_controller.dart';
import 'package:simple_pip_mode/simple_pip.dart';

void main() => runApp(const MileToReserveApp());

class MileToReserveApp extends StatefulWidget {
  const MileToReserveApp({super.key});

  @override
  State<MileToReserveApp> createState() => _MileToReserveAppState();
}

class _MileToReserveAppState extends State<MileToReserveApp>
    with WidgetsBindingObserver {
  final TrackingController controller = TrackingController();
  bool isInPip = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller.startTracking();
  }

  @override
  void dispose() {
    controller.stopTracking();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() => isInPip = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // PiP-Erkennung über Bildschirmbreite
    // final bool isPip = MediaQuery.of(context).size.width < 400;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("MilesTracker"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.picture_in_picture),
              onPressed: () => SimplePip().enterPipMode(),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.1),
            child: ButtonsPage(
              controller: controller,
              isPip: MediaQuery.of(context).size.width < 400,
            ),
          ),
        ),



      ),

      );
  }
}
