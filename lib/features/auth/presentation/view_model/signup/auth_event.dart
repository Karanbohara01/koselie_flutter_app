// part of 'auth_bloc.dart';

// abstract class AuthEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class AuthCheckRequested extends AuthEvent {} // 🔍 Check authentication

// class AuthLoginRequested extends AuthEvent {
//   final String username;
//   final String password;

//   AuthLoginRequested({required this.username, required this.password});

//   @override
//   List<Object?> get props => [username, password];
// }

// class AuthLogoutRequested extends AuthEvent {} // 🚪 Handle logout

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// 🔍 Check if the user is authenticated (Login Persistence)
class AuthCheckRequested extends AuthEvent {}

/// 🔹 Event to Handle User Login
class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  AuthLoginRequested({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

/// 🚪 Event to Handle Logout
class AuthLogoutRequested extends AuthEvent {}

/// 🔹 Event to Fetch All Users (NEW)
class GetAllUsersRequested extends AuthEvent {}
