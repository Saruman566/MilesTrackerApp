import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingController {
  final int _startMiles = 153; // Basiswert
  int milesBeforeRefuel = 153;
  Position? lastPosition;
  StreamSubscription<Position>? positionStream;
  String status = "Bereit";
  double _distanceMeters = 0; // interne Distanz in Metern
  Timer? _uiTimer; // Timer für UI-Updates alle 17 Sekunden

  // Notifier für normale App
  ValueNotifier<int> milesNotifier = ValueNotifier<int>(153);
  ValueNotifier<String> statusNotifier = ValueNotifier<String>("Bereit");

  // Notifier für PiP
  ValueNotifier<int> milesPipNotifier = ValueNotifier<int>(153);

  // ================== SharedPreferences ==================
  static const String _prefsKey = "milesBeforeRefuel";

  TrackingController() {
    // Automatisch gespeicherte Miles laden beim Erstellen
    _init();
  }

  Future<void> _init() async {
    await loadMiles();
  }

  Future<void> loadMiles() async {
    final prefs = await SharedPreferences.getInstance();
    milesBeforeRefuel = prefs.getInt(_prefsKey) ?? _startMiles;
    milesNotifier.value = milesBeforeRefuel;
    milesPipNotifier.value = milesBeforeRefuel;

    // distanceMeters so setzen, dass das Tracking nahtlos weiterläuft
    _distanceMeters = (_startMiles - milesBeforeRefuel) * 1609.34;
  }


  Future<void> saveMiles() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKey, milesBeforeRefuel);
  }

  // ================== Tracking ==================
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
      }

      lastPosition = position;
    });

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

    saveMiles(); // sofort speichern
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

      saveMiles(); // bei jedem Update speichern
    });
  }

  void stopUiTimer() {
    _uiTimer?.cancel();
    _uiTimer = null;
  }
}
