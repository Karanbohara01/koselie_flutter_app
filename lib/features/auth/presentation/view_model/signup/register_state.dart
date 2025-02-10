// part of 'register_bloc.dart';

// class RegisterState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final String? imageName;

//   const RegisterState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.imageName,
//   });

//   const RegisterState.initial()
//       : isLoading = false,
//         isSuccess = false,
//         imageName = null;

//   RegisterState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     String? imageName,
//   }) {
//     return RegisterState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       imageName: imageName ?? this.imageName,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, isSuccess, imageName];
// }

part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final bool imageUploaded;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.imageUploaded = false,
  });

  const RegisterState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        // imageName = '',// for testing
        imageUploaded = false;

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    bool? imageUploaded,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      imageUploaded: imageUploaded ?? this.imageUploaded,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName, imageUploaded];
}
