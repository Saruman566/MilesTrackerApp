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
    final double fontSize = isInPip ? 50 : 200;

    return Center(
      child: ValueListenableBuilder<int>(
        valueListenable: controller.milesNotifier,
        builder: (_, value, __) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logo.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                value > 0 ? '$value' : 'Reserve',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: controller.getMilesColor(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
