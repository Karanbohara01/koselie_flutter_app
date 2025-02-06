part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;

  final String username;
  final String password;
  final String? image;
  final String email;

  const RegisterUser({
    required this.context,
    required this.email,
    required this.username,
    required this.password,
    this.image,
  });
}
