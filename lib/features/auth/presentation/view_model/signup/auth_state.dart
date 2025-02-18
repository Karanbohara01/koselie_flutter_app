// part of 'auth_bloc.dart';

// abstract class AuthState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthAuthenticated extends AuthState {
//   final String token;
//   AuthAuthenticated({required this.token});

//   @override
//   List<Object> get props => [token];
// }

// class AuthUnauthenticated extends AuthState {}

// class AuthFailure extends AuthState {
//   final String message;
//   AuthFailure({required this.message});

//   @override
//   List<Object> get props => [message];
// }

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

/// 🔹 Initial State (Before authentication check)
class AuthInitial extends AuthState {}

/// 🔄 Loading State (During login)
class AuthLoading extends AuthState {}

/// ✅ User is Authenticated
class AuthAuthenticated extends AuthState {
  final String token;
  AuthAuthenticated({required this.token});

  @override
  List<Object> get props => [token];
}

/// ❌ User is Not Authenticated
class AuthUnauthenticated extends AuthState {}

/// 🔴 Authentication Failure (Login Error)
class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

/// 🔄 Loading Users (While fetching user list)
class AuthLoadingUsers extends AuthState {}

/// ✅ Successfully Loaded All Users
class AuthUsersLoaded extends AuthState {
  final List<AuthEntity> users;
  AuthUsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

/// ❌ Failed to Load Users
class AuthUsersFailure extends AuthState {
  final String message;
  AuthUsersFailure({required this.message});

  @override
  List<Object> get props => [message];
}
