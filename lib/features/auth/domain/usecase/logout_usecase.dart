import 'package:dartz/dartz.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/core/error/failure.dart';

class LogoutUseCase {
  final TokenSharedPrefs tokenPrefs;

  LogoutUseCase(this.tokenPrefs);

  Future<Either<Failure, void>> call() async {
    return await tokenPrefs.removeToken();
  }
}
