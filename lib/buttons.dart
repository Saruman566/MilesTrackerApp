import 'package:flutter/material.dart';
import 'tracking_miles.dart';
import 'tracking_controller.dart';

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
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: TrackingMiles(controller: controller, isPip: isPip),
    );
  }
}
