part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String username;
  final String password;
  final String email;

  const RegisterUser(
      {required this.username,
      required this.email,
      required this.password,
      required this.context});

  @override
  List<Object> get props => [username, email, password];
}
