import 'package:flutter/material.dart';
import 'buttons.dart';
import 'tracking_controller.dart';
import 'package:simple_pip_mode/simple_pip.dart';
import 'pip_view.dart';

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

  void enterPip() {
    SimplePip().enterPipMode();
    setState(() => isInPip = true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox.expand(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/backgroundapp.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                  child: ButtonsPage(
                    trackingController: controller,
                    isPip: MediaQuery.of(context).size.width < 400,
                  ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.866,
              right: MediaQuery.of(context).size.width * 0.618,
              child: ElevatedButton(
                onPressed: enterPip,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                  ),
                  child: Text(
                    'MT',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),
            ),
            if (isInPip)
              PipOverlay(controller: controller, isInPip: true),
          ],
        ),
      ),
    );
  }
}
