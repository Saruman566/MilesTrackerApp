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
      children: [ Padding(
        padding: const EdgeInsets.fromLTRB(75, 0, 0, 2),
        child: ValueListenableBuilder<String>(
          valueListenable: widget.controller.statusNotifier,
          builder: (_, value, __) => Text(
            value != '0' ? '$value' : 'Reserve',
            style: TextStyle(
              fontSize: widget.isPip ? 12 : 19,
              color: Colors.white70,
            ),
          ),
        ),
      ),
        ValueListenableBuilder<int>(
          valueListenable: widget.controller.milesNotifier,
          builder: (_, value, __) => Text(
            value != 0 ? '$value' : 'Reserve',
            style: TextStyle(
              fontSize: widget.isPip ? 50 : 110,
              fontWeight: FontWeight.bold,
              color: widget.controller.getMilesColor(),
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

