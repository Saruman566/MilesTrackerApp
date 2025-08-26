import 'package:flutter/material.dart';
import 'tracking_controller.dart';

class PipOverlay extends StatelessWidget {
  final TrackingController controller;
  final bool isInPip; // Steuert, ob PiP-Modus aktiv ist

  const PipOverlay({
    super.key,
    required this.controller,
    required this.isInPip,
  });

  @override
  Widget build(BuildContext context) {
    final double fontSize = isInPip ? 50 : 200; // Dynamische Größe

    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: controller.milesNotifier,
        builder: (_, value, __) {
          return FittedBox(
            fit: BoxFit.contain,
            child: Text(
              value > 0 ? '$value miles' : 'Reserve',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: controller.getMilesColor(),
              ),
            ),
          );
        },
      ),
    );
  }
}
