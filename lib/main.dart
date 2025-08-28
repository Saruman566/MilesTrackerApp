import 'package:flutter/material.dart';
import 'buttons.dart';
import 'tracking_controller.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/backgroundapp.png'),
                  fit: BoxFit.cover, // füllt gesamte Fläche
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(55),
                child: ButtonsPage(
                  controller: controller,
                  isPip: MediaQuery.of(context).size.width < 400,
                ),
              ),
            ),
          ),
        ),
      ),
      );
  }
}
