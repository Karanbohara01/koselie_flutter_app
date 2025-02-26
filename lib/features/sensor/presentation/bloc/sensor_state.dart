abstract class SensorState {}

class SensorInitial extends SensorState {}

class ShakeDetected extends SensorState {}

class SensorError extends SensorState {
  final String message;
  SensorError(this.message);

  @override
  String toString() => 'SensorError: $message'; // ✅ For easier debugging
}
