// part of 'register_bloc.dart';

// class RegisterState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final String? imageName;
//   final bool imageUploaded;

//   const RegisterState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.imageName,
//     this.imageUploaded = false,
//   });

//   const RegisterState.initial()
//       : isLoading = false,
//         isSuccess = false,
//         imageName = null,
//         // imageName = '',// for testing
//         imageUploaded = false;

//   RegisterState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     String? imageName,
//     bool? imageUploaded,
//   }) {
//     return RegisterState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       imageName: imageName ?? this.imageName,
//       imageUploaded: imageUploaded ?? this.imageUploaded,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, isSuccess, imageName, imageUploaded];
// }

//  for integration tes
part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final bool imageUploaded;
  final String? errorMessage; // Added

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.imageUploaded = false,
    this.errorMessage, // Added
  });

  const RegisterState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        imageUploaded = false,
        errorMessage = null; // Fixed error

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    bool? imageUploaded,
    String? errorMessage, // Added
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      imageUploaded: imageUploaded ?? this.imageUploaded,
      errorMessage: errorMessage ?? this.errorMessage, // Fixed missing field
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, isSuccess, imageName, imageUploaded, errorMessage];
}
