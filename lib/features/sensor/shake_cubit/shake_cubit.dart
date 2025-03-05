import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeCubit extends Cubit<void> {
  StreamSubscription? _accelerometerSubscription;

  ShakeCubit() : super(null) {
    _startListening();
  }

  void _startListening() {
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      double shakeThreshold = 12.0; // Adjust sensitivity as needed
      double acceleration =
          (event.x * event.x) + (event.y * event.y) + (event.z * event.z);

      if (acceleration > shakeThreshold) {
        emit(null); // Trigger a UI refresh
      }
    });
  }

  @override
  Future<void> close() {
    _accelerometerSubscription?.cancel();
    return super.close();
  }
}
