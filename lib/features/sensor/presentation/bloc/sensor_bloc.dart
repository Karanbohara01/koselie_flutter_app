import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/sensor/domain/usecases/detect_shake_usecase.dart';

import 'sensor_event.dart';
import 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final DetectShake detectShake; // ✅ Now using DetectShake
  final AuthBloc authBloc;
  StreamSubscription<bool>? _shakeSubscription;

  SensorBloc({required this.detectShake, required this.authBloc})
      : super(SensorInitial()) {
    on<StartListeningForShake>(_startListening);
    on<ShakeDetectedEvent>(_handleShakeDetected);
  }

  void _startListening(
      StartListeningForShake event, Emitter<SensorState> emit) {
    _shakeSubscription?.cancel(); // Cancel existing listener

    _shakeSubscription = detectShake().listen((isShaking) {
      print("📡 Shake Detection Result: $isShaking");

      if (isShaking) {
        print("🚀 Shake detected! Sending event to logout.");
        add(ShakeDetectedEvent()); // ✅ Dispatch event when shake is detected
      }
    }, onError: (error) {
      print("❌ Sensor Error: $error");
      emit(SensorError(error.toString()));
    });
  }

  void _handleShakeDetected(
      ShakeDetectedEvent event, Emitter<SensorState> emit) {
    print("🔴 Triggering logout...");
    emit(ShakeDetected()); // ✅ Shake detected state
    authBloc.add(AuthLogoutRequested()); // ✅ Now actually logs out user!
  }

  @override
  Future<void> close() {
    _shakeSubscription?.cancel(); // ✅ Ensure cleanup
    return super.close();
  }
}
