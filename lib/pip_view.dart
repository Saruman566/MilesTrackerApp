import 'package:flutter/material.dart';
import 'tracking_controller.dart';

class PipOverlay extends StatelessWidget {
  final TrackingController controller;
  final bool isInPip;

  const PipOverlay({
    super.key,
    required this.controller,
    required this.isInPip,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: controller.milesNotifier,
        builder: (_, miles, __) {
          // Schriftgröße abhängig von PIP und Wert
          final double fontSize = isInPip
              ? (miles == 0 ? 23 : 50)
              : (miles == 0 ? 150 : 200);

          return Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
                fit: BoxFit.none,
                scale: 7,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                miles > 0 ? '$miles' : 'Reserve',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: controller.getMilesColor(),
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
