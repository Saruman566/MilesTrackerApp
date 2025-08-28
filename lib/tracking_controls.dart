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
      padding: const EdgeInsets.fromLTRB(0, 147, 0, 2), // Padding um die gesamte Row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // zentriert die Icons in der Row
        children: [
          Flexible(
            child: IconButton(
              icon: Image.asset('images/play.png',
                width: 100,
                height: 100,
              ),
              onPressed: onStart,
            ),

          ),
          Flexible(
            child: IconButton(
              icon: Image.asset('images/stop.png'),
              onPressed: onStop,
            ),
          ),
          Flexible(
            child: IconButton(
              icon: Image.asset('images/reset.png'),
              onPressed: onReset,
            ),
          ),
        ],
      ),
    );
  }}
