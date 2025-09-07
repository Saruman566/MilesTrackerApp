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
              builder: (_, status, __) {
                final miles = widget.controller.milesNotifier.value;
                return Padding(
                  padding: miles != 0
                      ? const EdgeInsets.only(top: 0, left: 10, bottom: 0)
                      : const EdgeInsets.only(top: 0, left: 10, bottom: 50),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: widget.isPip ? 12 : 19,
                      color: Colors.white70,
                    ),
                  ),
                );
              },
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -10),
            child: ValueListenableBuilder<int>(
              valueListenable: widget.controller.milesNotifier,
              builder: (_, value, __) {
                final screenWidth = MediaQuery.of(context).size.width;

                double fontSize = (value == 0)
                    ? (widget.isPip ? screenWidth * 0.08 : screenWidth * 0.14)
                    : (widget.isPip ? screenWidth * 0.1 : screenWidth * 0.275);

                double spacing = (value == 0)
                    ? (widget.isPip ? 4 : 140)
                    : (widget.isPip ? 4 : 110);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      value != 0 ? '$value' : ' Reserve',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: widget.controller.getMilesColor(),
                      ),
                    ),
                    SizedBox(height: spacing),
                    TrackingControls(
                      onStart: () => widget.controller.startTracking(),
                      onStop: () => widget.controller.stopTracking(),
                      onReset: () => widget.controller.resetMiles(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
