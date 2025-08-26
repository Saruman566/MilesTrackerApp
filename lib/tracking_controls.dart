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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Image.asset('images/play.png'), onPressed: onStart),
        IconButton(icon: Image.asset('images/stop.png'), onPressed: onStop),
        IconButton(icon: Image.asset('images/reset.png'), onPressed: onReset),
      ],
    );
  }
}
