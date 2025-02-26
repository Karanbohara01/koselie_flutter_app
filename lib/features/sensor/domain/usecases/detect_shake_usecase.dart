import '../repositories/sensor_repository.dart';

class DetectShake {
  final SensorRepository repository;

  DetectShake({required this.repository});

  Stream<bool> call() {
    return repository.detectShake();
  }
}
