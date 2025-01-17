part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String userName;
  final String password;
  final String email;

  const RegisterUser(
      {required this.userName,
      required this.email,
      required this.password,
      required this.context});

  @override
  List<Object> get props => [userName, email, password];
}
