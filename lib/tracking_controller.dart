import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TrackingController {
  final int _startMiles = 153; // Basiswert
  int milesBeforeRefuel = 153;
  Position? lastPosition;
  StreamSubscription<Position>? positionStream;
  String status = "Bereit";
  double _distanceMeters = 0; // interne Distanz in Metern
  Timer? _uiTimer; // Timer für UI-Updates alle 250 Sekunden

  // Notifier für normale App
  ValueNotifier<int> milesNotifier = ValueNotifier<int>(153);
  ValueNotifier<String> statusNotifier = ValueNotifier<String>("Bereit");

  // Notifier für PiP
  ValueNotifier<int> milesPipNotifier = ValueNotifier<int>(153);

  Future<void> startTracking() async {
    if (positionStream != null) return;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _updateStatus("GPS deaktiviert");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _updateStatus("Keine Berechtigung");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _updateStatus("Dauerhaft verweigert");
      return;
    }

    _updateStatus("Tracking gestartet");

    // Stream für Positionsupdates
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
        timeLimit: Duration(seconds: 30),
      ),
    ).listen((Position position) {
      if (lastPosition != null) {
        final distanceInMeters = Geolocator.distanceBetween(
          lastPosition!.latitude,
          lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );

        _distanceMeters += distanceInMeters;

        // Debug-Ausgabe
        // print("Gefahren: ${_distanceMeters.toStringAsFixed(1)} m");
      }

      lastPosition = position;
    });

    // Timer für UI-Updates alle 250 Sekunden
    startUiTimer();
  }

  void stopTracking() {
    positionStream?.cancel();
    positionStream = null;
    stopUiTimer();
    _updateStatus("Tracking gestoppt");
  }

  void resetMiles() {
    milesBeforeRefuel = _startMiles;
    lastPosition = null;
    _distanceMeters = 0;

    milesNotifier.value = milesBeforeRefuel;
    milesPipNotifier.value = milesBeforeRefuel;

    stopTracking();

    _updateStatus("Zurückgesetzt");
  }

  void _updateStatus(String newStatus) {
    status = newStatus;
    statusNotifier.value = newStatus;
  }

  Color getMilesColor() {
    if (milesBeforeRefuel > 100) return Colors.green;
    if (milesBeforeRefuel > 50) return Colors.orange;
    return Colors.red;
  }

  // ===================== Timer für UI =====================
  void startUiTimer() {
    _uiTimer?.cancel();
    _uiTimer = Timer.periodic(const Duration(seconds: 17), (_) {
      milesBeforeRefuel = _startMiles - (_distanceMeters / 1609.34).floor();
      if (milesBeforeRefuel < 0) milesBeforeRefuel = 0;

      milesNotifier.value = milesBeforeRefuel;
      milesPipNotifier.value = milesBeforeRefuel;
      _updateStatus("Tracking aktiv");

      // Debug-Ausgabe
      print("UI-Update: Rest=$milesBeforeRefuel mi");
    });
  }

  void stopUiTimer() {
    _uiTimer?.cancel();
    _uiTimer = null;
  }
}
