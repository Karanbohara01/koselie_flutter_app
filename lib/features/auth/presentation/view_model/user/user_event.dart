part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

/// 🔹 Event to Fetch Logged-In User Info
final class GetUserInfoEvent extends UserEvent {}
