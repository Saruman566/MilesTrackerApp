import 'package:flutter/material.dart';
import 'tracking_controller.dart';
import 'tracking_controls.dart';


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
        Padding(
        padding: const EdgeInsets.fromLTRB(75, 0, 0, 0),
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
    Transform.translate(
    offset: const Offset(0, -10),
    child: ValueListenableBuilder<int>(
          valueListenable: widget.controller.milesNotifier,
          builder: (_, value, __) => Text(
            value != 0 ? '$value' : 'Reserve',
            style: TextStyle(
              fontSize: widget.isPip ? 50 : 125,
              fontWeight: FontWeight.bold,
              color: widget.controller.getMilesColor(),
            ),
          ),
        ),
    ),
        const SizedBox(height: 8),
        TrackingControls(
          onStart: () => widget.controller.startTracking(),
          onStop: () => widget.controller.stopTracking(),
          onReset: () => widget.controller.resetMiles(),
        ),
      ],),
    );
  }
}

