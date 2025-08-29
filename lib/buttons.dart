import 'package:flutter/material.dart';
import 'tracking_miles.dart';
import 'tracking_controller.dart';
import 'MilesInput.dart';

class ButtonsPage extends StatelessWidget {
  final TrackingController controller;
  final bool isPip;

  const ButtonsPage({
    super.key,
    required this.controller,
    required this.isPip,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 900,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TrackingMiles(
              controller: controller,
              isPip: isPip,
            ),
            const SizedBox(height: 118),
            MilesInput(),
          ],
        ),
      ),
    );
  }


}