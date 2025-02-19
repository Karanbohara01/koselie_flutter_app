

part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

// ✅ Navigate to Register Screen
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

// ✅ Navigate to Home Screen
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

// ✅ Handle Login
class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final String username;
  final String password;

  const LoginUserEvent({
    required this.context,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [context, username, password];
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

// ✅ Fetch Logged-in User Info
class GetUserInfoEvent extends LoginEvent {
  final BuildContext context;

  const GetUserInfoEvent({required this.context});

  @override
  List<Object?> get props => [context];
}

// ✅ Update Profile (Username, Bio, Role)
class UpdateUserProfileEvent extends LoginEvent {
  final BuildContext context;
  final String username;
  final String bio;
  final String role;

  const UpdateUserProfileEvent({
    required this.context,
    required this.username,
    required this.bio,
    required this.role,
  });

  @override
  List<Object?> get props => [context, username, bio, role];
}

// ✅ Update Profile Picture
class UpdateProfilePictureEvent extends LoginEvent {
  final BuildContext context;
  final File profilePicture;

  const UpdateProfilePictureEvent({
    required this.context,
    required this.profilePicture,
  });

  @override
  List<Object?> get props => [context, profilePicture];
}

// // For testing only
// part of 'login_bloc.dart';

// sealed class LoginEvent extends Equatable {
//   const LoginEvent();

//   @override
//   List<Object?> get props => [];
// }

// class LoginUserEvent extends LoginEvent {
//   final String username;
//   final String password;

//   const LoginUserEvent({
//     required this.username,
//     required this.password,
//   });

//   @override
//   List<Object?> get props => [username, password];
// }

// class ShowSnackbarEvent extends LoginEvent {
//   final String message;

//   const ShowSnackbarEvent({required this.message});

//   @override
//   List<Object?> get props => [message];
// }

// class NavigateToHomeEvent extends LoginEvent {
//   @override
//   List<Object?> get props => [];
// }
