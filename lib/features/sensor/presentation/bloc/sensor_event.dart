abstract class SensorEvent {}

class StartListeningForShake extends SensorEvent {}

class ShakeDetectedEvent
    extends SensorEvent {} // ✅ Used instead of direct `emit()`
