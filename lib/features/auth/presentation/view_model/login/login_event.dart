// part of 'login_bloc.dart';

// sealed class LoginEvent extends Equatable {
//   const LoginEvent();

//   @override
//   List<Object> get props => [];
// }

// class NavigateRegisterScreenEvent extends LoginEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateRegisterScreenEvent({
//     required this.context,
//     required this.destination,
//   });
// }

// class NavigateHomeScreenEvent extends LoginEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateHomeScreenEvent({
//     required this.context,
//     required this.destination,
//   });
// }

// class LoginUserEvent extends LoginEvent {
//   final BuildContext context;
//   final String userName;
//   final String password;

//   const LoginUserEvent({
//     required this.context,
//     required this.userName,
//     required this.password,
//   });
// }

part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class NavigateRegisterScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object?> get props => [context, destination];
}

class NavigateHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object?> get props => [context, destination];
}

class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final String userName;
  final String password;

  const LoginUserEvent({
    required this.context,
    required this.userName,
    required this.password,
  });

  @override
  List<Object?> get props => [context, userName, password];
}

class LoginSuccessEvent extends LoginEvent {
  final String token;

  const LoginSuccessEvent({required this.token});

  @override
  List<Object?> get props => [token];
}

class LoginFailureEvent extends LoginEvent {
  final String errorMessage;

  const LoginFailureEvent({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
