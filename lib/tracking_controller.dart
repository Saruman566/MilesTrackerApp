import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TrackingController {
  int milesBeforeRefuel = 153;
  Position? lastPosition;
  StreamSubscription<Position>? positionStream;
  String status = "Bereit";

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

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      if (lastPosition != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          lastPosition!.latitude,
          lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );

        int distanceInMiles = (distanceInMeters / 1609.34).round();
        milesBeforeRefuel -= distanceInMiles;
        if (milesBeforeRefuel < 0) milesBeforeRefuel = 0;

        // Alle UI-Updates auf dem Hauptthread
        WidgetsBinding.instance.addPostFrameCallback((_) {
          milesNotifier.value = milesBeforeRefuel;
          milesPipNotifier.value = milesBeforeRefuel;
          _updateStatus("Tracking aktiv");
        });
      }

      lastPosition = position;
    });
  }

  void stopTracking() {
    positionStream?.cancel();
    positionStream = null;
    _updateStatus("Tracking gestoppt");
  }

  void resetMiles() {
    milesBeforeRefuel = 153;
    lastPosition = null;
    milesNotifier.value = milesBeforeRefuel;
    milesPipNotifier.value = milesBeforeRefuel;

    if (positionStream != null) {
      stopTracking();
    }

    _updateStatus("Zurückgesetzt");
  }

  void _updateStatus(String newStatus) {
    status = newStatus;
    statusNotifier.value = newStatus; // Notifier aktualisieren
  }

  Color getMilesColor() {
    if (milesBeforeRefuel > 100) return Colors.green;
    if (milesBeforeRefuel > 50) return Colors.orange;
    return Colors.red;
  }
}
