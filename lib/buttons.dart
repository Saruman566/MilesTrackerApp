import 'package:flutter/material.dart';
import 'tracking_miles.dart';
import 'tracking_controller.dart';
import 'MilesInput.dart';

class ButtonsPage extends StatefulWidget {
  final TrackingController trackingController;
  final bool isPip;

  const ButtonsPage({
    super.key,
    required this.trackingController,
    required this.isPip,
  });

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TrackingMiles(
              controller: widget.trackingController,
              isPip: widget.isPip,
            ),
            MilesInput(
              controller: widget.trackingController,
              onMilesChanged: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
