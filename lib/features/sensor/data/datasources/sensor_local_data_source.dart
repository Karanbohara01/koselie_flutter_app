import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

abstract class SensorLocalDataSource {
  Stream<bool> detectShake();
}

class SensorLocalDataSourceImpl implements SensorLocalDataSource {
  static const double SHAKE_THRESHOLD = 15.0; // Adjust sensitivity
  AccelerometerEvent? lastEvent;
  final _shakeController = StreamController<bool>.broadcast();

  SensorLocalDataSourceImpl() {
    accelerometerEvents.listen((event) {
      if (lastEvent != null) {
        double deltaX = (event.x - lastEvent!.x).abs();
        double deltaY = (event.y - lastEvent!.y).abs();
        double deltaZ = (event.z - lastEvent!.z).abs();

        double shakeMagnitude = deltaX + deltaY + deltaZ;
        if (shakeMagnitude > SHAKE_THRESHOLD) {
          _shakeController.add(true); // Shake detected
        }
      }
      lastEvent = event;
    });
  }

  @override
  Stream<bool> detectShake() => _shakeController.stream;
}
