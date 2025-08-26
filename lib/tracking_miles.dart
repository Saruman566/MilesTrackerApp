import 'package:flutter/material.dart';        // ✅ für Widget, Column, Text, etc.
import 'tracking_controller.dart';             // ✅ für TrackingController
import 'tracking_controls.dart';               // ✅ für TrackingControls


class TrackingMiles extends StatefulWidget {
  final TrackingController controller;
  final bool isPip;

  const TrackingMiles({
    super.key,
    required this.controller,
    required this.isPip,
  });

  @override
  State<TrackingMiles> createState() => _TrackingMilesState();
}

class _TrackingMilesState extends State<TrackingMiles> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: widget.controller.milesNotifier,
          builder: (_, value, __) => Text(
            "$value",
            style: TextStyle(
              fontSize: widget.isPip ? 50 : 90,
              fontWeight: FontWeight.bold,
              color: widget.controller.getMilesColor(),
            ),
          ),
        ),
      ValueListenableBuilder<String>(
        valueListenable: widget.controller.statusNotifier,
        builder: (_, value, __) => Text(
          value,
          style: TextStyle(
            fontSize: widget.isPip ? 12 : 16,
            color: Colors.white70,
          ),
        ),


    ),
        const SizedBox(height: 30),
        TrackingControls(
          onStart: () => widget.controller.startTracking(),
          onStop: () => widget.controller.stopTracking(),
          onReset: () => widget.controller.resetMiles(),
        ),
      ],),
    );
  }
}

