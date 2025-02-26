import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/bio-metric/domain/repository/biometric_repository.dart';

class BiometricState {
  final bool isAuthenticated;
  final bool hasError;

  BiometricState({this.isAuthenticated = false, this.hasError = false});
}

class BiometricBloc extends Cubit<BiometricState> {
  final BiometricRepository biometricRepository;

  BiometricBloc({required this.biometricRepository}) : super(BiometricState());

  Future<void> authenticate() async {
    final isAuthenticated = await biometricRepository.authenticateUser();
    emit(BiometricState(
      isAuthenticated: isAuthenticated,
      hasError: !isAuthenticated,
    ));
  }
}
