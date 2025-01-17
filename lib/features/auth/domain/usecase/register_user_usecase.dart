import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String userName;
  final String password;

  final String email;

  const RegisterUserParams({
    required this.password,
    required this.email,
    required this.userName,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  List<Object?> get props => [userName, email, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      password: params.password,
      email: params.email,
      userName: params.userName,
    );
    return repository.registerUser(authEntity);
  }
}
