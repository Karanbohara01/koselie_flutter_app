// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:koselie/features/sensor/domain/usecases/detect_shake_usecase.dart';

// import 'sensor_event.dart';
// import 'sensor_state.dart';

// class SensorBloc extends Bloc<SensorEvent, SensorState> {
//   final DetectShake detectShake; // ✅ Now using DetectShake
//   final AuthBloc authBloc;
//   StreamSubscription<bool>? _shakeSubscription;

//   SensorBloc({required this.detectShake, required this.authBloc})
//       : super(SensorInitial()) {
//     on<StartListeningForShake>(_startListening);
//     on<ShakeDetectedEvent>(_handleShakeDetected);
//   }

//   void _startListening(
//       StartListeningForShake event, Emitter<SensorState> emit) {
//     _shakeSubscription?.cancel(); // Cancel existing listener

//     _shakeSubscription = detectShake().listen((isShaking) {
//       print("📡 Shake Detection Result: $isShaking");

//       if (isShaking) {
//         print("🚀 Shake detected! Sending event to logout.");
//         add(ShakeDetectedEvent()); // ✅ Dispatch event when shake is detected
//       }
//     }, onError: (error) {
//       print("❌ Sensor Error: $error");
//       emit(SensorError(error.toString()));
//     });
//   }

//   void _handleShakeDetected(
//       ShakeDetectedEvent event, Emitter<SensorState> emit) {
//     print("🔴 Triggering logout...");
//     emit(ShakeDetected()); // ✅ Shake detected state
//     authBloc.add(AuthLogoutRequested()); // ✅ Now actually logs out user!
//   }

//   @override
//   Future<void> close() {
//     _shakeSubscription?.cancel(); // ✅ Ensure cleanup
//     return super.close();
//   }
// }
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/sensor/domain/usecases/detect_shake_usecase.dart';

import 'sensor_event.dart';
import 'sensor_state.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  final DetectShake detectShake;
  final AuthBloc authBloc;
  StreamSubscription<dynamic>? _shakeSubscription;
  DateTime _lastLogoutTime = DateTime.now(); // 🔴 Cooldown tracker

  SensorBloc({required this.detectShake, required this.authBloc})
      : super(SensorInitial()) {
    on<StartListeningForShake>(_startListening);
    on<ShakeDetectedEvent>(_handleShakeDetected);
  }

  void _startListening(
      StartListeningForShake event, Emitter<SensorState> emit) {
    _shakeSubscription
        ?.cancel(); // ✅ Cancel existing listener before starting a new one

    _shakeSubscription = detectShake().listen((shakeData) {
      print("📡 Shake Detection Result: $shakeData");

      // 🔥 Ensure shakeData is a number (handle cases where it's bool)
      double shakeIntensity;

      shakeIntensity = shakeData ? 20.0 : 0.0; // ✅ Convert bool to double

      if (shakeIntensity > 18.0) {
        // ✅ Hard Shake Threshold
        DateTime now = DateTime.now();

        if (now.difference(_lastLogoutTime) > const Duration(seconds: 5)) {
          // ✅ 5-sec cooldown
          print("🚀 Hard shake detected! Triggering logout.");
          _lastLogoutTime = now;
          add(ShakeDetectedEvent()); // ✅ Dispatch event when shake is strong enough
        } else {
          print("⏳ Cooldown active, ignoring shake.");
        }
      }

      if (shakeIntensity > 18.0) {
        // ✅ Hard Shake Threshold
        DateTime now = DateTime.now();

        if (now.difference(_lastLogoutTime) > const Duration(seconds: 5)) {
          // ✅ 5-sec cooldown
          print("🚀 Hard shake detected! Triggering logout.");
          _lastLogoutTime = now;
          add(ShakeDetectedEvent()); // ✅ Dispatch event when shake is strong enough
        } else {
          print("⏳ Cooldown active, ignoring shake.");
        }
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
    _shakeSubscription?.cancel(); // ✅ Ensure cleanup of sensor listener
    return super.close();
  }
}
