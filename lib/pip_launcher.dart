import 'package:flutter/material.dart';
import 'tracking_controller.dart';
import 'package:simple_pip_mode/simple_pip.dart';

void launchPip(TrackingController controller) {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: ValueListenableBuilder<int>(
            valueListenable: controller.milesNotifier,
            builder: (context, value, _) {
              return Text(
                value > 0 ? '$value miles' : 'Reserve',
                style: TextStyle(
                  fontSize: 200,
                  color: controller.getMilesColor(),
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
    ),
  );

  SimplePip().enterPipMode();
}
