import 'package:local_auth/local_auth.dart';

class BiometricRepository {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    return await _localAuth.canCheckBiometrics;
  }

  Future<bool> authenticateUser() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: "Authenticate to access your account",
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
