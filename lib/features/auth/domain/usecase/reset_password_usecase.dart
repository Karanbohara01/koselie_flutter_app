import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/app/usecase/usecase.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class ResetPasswordParams extends Equatable {
  final String? email;
  final String? phone;
  final String otp;
  final String newPassword;

  const ResetPasswordParams({
    this.email,
    this.phone,
    required this.otp,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [email, phone, otp, newPassword];
}

class ResetPasswordUseCase
    implements UsecaseWithParams<void, ResetPasswordParams> {
  final IAuthRepository repository;

  ResetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      email: params.email,
      phone: params.phone,
      otp: params.otp,
      newPassword: params.newPassword,
    );
  }
}
