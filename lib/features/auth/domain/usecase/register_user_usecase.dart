import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String username;
  final String password;
  final String? image;
  final String email;

  const RegisterUserParams({
    required this.password,
    required this.email,
    required this.username,
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.email,
    required this.password,
    required this.username,
    this.image,
  });

  @override
  List<Object?> get props => [username, email, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      password: params.password,
      email: params.email,
      username: params.username,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
