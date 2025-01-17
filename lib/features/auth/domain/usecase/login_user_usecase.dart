import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String userName;
  final String password;

  const LoginParams({
    required this.userName,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : userName = '',
        password = '';

  @override
  List<Object> get props => [userName, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.loginUser(params.userName, params.password);
  }
}
