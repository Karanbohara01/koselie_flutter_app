// part of 'login_bloc.dart';

// class LoginState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final AuthEntity? user; // ✅ Store logged-in user details
//   final bool isProfileUpdated; // ✅ Tracks if profile update was successful
//   final bool isProfilePictureUpdated; // ✅ Tracks if profile picture was updated
//   final String errorMessage; // ✅ Stores error messages

//   const LoginState({
//     required this.isLoading,
//     required this.isSuccess,
//     required this.user,
//     required this.isProfileUpdated,
//     required this.isProfilePictureUpdated,
//     this.errorMessage = "",
//   });

//   /// ✅ Initial State
//   factory LoginState.initial() {
//     return const LoginState(
//       isLoading: false,
//       isSuccess: false,
//       user: null,
//       isProfileUpdated: false,
//       isProfilePictureUpdated: false,
//       errorMessage: "",
//     );
//   }

//   /// ✅ CopyWith for updating state
//   LoginState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     AuthEntity? user,
//     bool? isProfileUpdated,
//     bool? isProfilePictureUpdated,
//     String? errorMessage,
//   }) {
//     return LoginState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       user: user ?? this.user,
//       isProfileUpdated: isProfileUpdated ?? this.isProfileUpdated,
//       isProfilePictureUpdated:
//           isProfilePictureUpdated ?? this.isProfilePictureUpdated,
//       errorMessage: errorMessage ?? "",
//     );
//   }

//   @override
//   List<Object?> get props => [
//         isLoading,
//         isSuccess,
//         user,
//         isProfileUpdated,
//         isProfilePictureUpdated,
//         errorMessage,
//       ];
// }

// for testing only

// part of 'login_bloc.dart';

// class LoginState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;

//   const LoginState({required this.isLoading, required this.isSuccess});

//   factory LoginState.initial() {
//     return const LoginState(isLoading: false, isSuccess: false);
//   }

//   LoginState copyWith({bool? isLoading, bool? isSuccess}) {
//     return LoginState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, isSuccess];
// }

//  **************************************************************** //
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final AuthEntity? user; // ✅ Store logged-in user details
  final bool isProfileUpdated; // ✅ Tracks if profile update was successful
  final bool isProfilePictureUpdated; // ✅ Tracks if profile picture was updated
  final bool isOtpSent; // ✅ Tracks if OTP was sent successfully
  final bool isPasswordReset; // ✅ Tracks if password was reset successfully
  final String errorMessage; // ✅ Stores error messages

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    required this.user,
    required this.isProfileUpdated,
    required this.isProfilePictureUpdated,
    required this.isOtpSent,
    required this.isPasswordReset,
    this.errorMessage = "",
  });

  /// ✅ Initial State
  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      isSuccess: false,
      user: null,
      isProfileUpdated: false,
      isProfilePictureUpdated: false,
      isOtpSent: false,
      isPasswordReset: false,
      errorMessage: "",
    );
  }

  /// ✅ CopyWith for updating state
  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AuthEntity? user,
    bool? isProfileUpdated,
    bool? isProfilePictureUpdated,
    bool? isOtpSent,
    bool? isPasswordReset,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
      isProfileUpdated: isProfileUpdated ?? this.isProfileUpdated,
      isProfilePictureUpdated:
          isProfilePictureUpdated ?? this.isProfilePictureUpdated,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      errorMessage: errorMessage ?? "",
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        user,
        isProfileUpdated,
        isProfilePictureUpdated,
        isOtpSent,
        isPasswordReset,
        errorMessage,
      ];
}
