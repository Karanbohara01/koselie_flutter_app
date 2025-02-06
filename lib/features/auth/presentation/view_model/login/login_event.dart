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
//   final String username;
//   final String password;

//   const LoginUserEvent({
//     required this.context,
//     required this.username,
//     required this.password,
//   });
// }

// part of 'login_bloc.dart';

// sealed class LoginEvent extends Equatable {
//   const LoginEvent();

//   @override
//   List<Object?> get props => [];
// }

// class NavigateRegisterScreenEvent extends LoginEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateRegisterScreenEvent({
//     required this.context,
//     required this.destination,
//   });

//   @override
//   List<Object?> get props => [context, destination];
// }

// class NavigateHomeScreenEvent extends LoginEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateHomeScreenEvent({
//     required this.context,
//     required this.destination,
//   });

//   @override
//   List<Object?> get props => [context, destination];
// }

// class LoginUserEvent extends LoginEvent {
//   final BuildContext context;
//   final String username;
//   final String password;

//   const LoginUserEvent({
//     required this.context,
//     required this.username,
//     required this.password,
//   });

//   @override
//   List<Object?> get props => [context, username, password];
// }

// class LoginSuccessEvent extends LoginEvent {
//   final String token;

//   const LoginSuccessEvent({required this.token});

//   @override
//   List<Object?> get props => [token];
// }

// class LoginFailureEvent extends LoginEvent {
//   final String errorMessage;

//   const LoginFailureEvent({required this.errorMessage});

//   @override
//   List<Object?> get props => [errorMessage];
// }

// For testing only
part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final String username;
  final String password;

  const LoginUserEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class ShowSnackbarEvent extends LoginEvent {
  final String message;

  const ShowSnackbarEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class NavigateToHomeEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
