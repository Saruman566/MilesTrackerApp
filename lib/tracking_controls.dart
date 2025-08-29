import 'package:flutter/material.dart';

class TrackingControls extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onReset;

  const TrackingControls({
    super.key,
    required this.onStart,
    required this.onStop,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 133, 0, 0),
      child: SizedBox(
        width: 900,
        height: 92,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Start Button
            _buildButton(onStart, 15, 7),
            const SizedBox(width: 5),
            // Stop Button
            _buildButton(onStop, 0, 7),
            const SizedBox(width: 5),
            // Reset Button
            _buildButton(onReset, 0, 10),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(VoidCallback onTap, double paddingLeft, double paddingRight) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingRight, 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
