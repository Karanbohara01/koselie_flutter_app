import '../../domain/repositories/sensor_repository.dart';
import '../datasources/sensor_local_data_source.dart';

class SensorRepositoryImpl implements SensorRepository {
  final SensorLocalDataSource localDataSource;

  SensorRepositoryImpl({required this.localDataSource});

  @override
  Stream<bool> detectShake() {
    return localDataSource.detectShake();
  }
}
