import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/usecase/get_current_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  UserBloc({required GetCurrentUserUseCase getCurrentUserUseCase})
      : _getCurrentUserUseCase = getCurrentUserUseCase,
        super(UserInitial()) {
    on<GetUserInfoEvent>(_onGetUserInfo);
  }

  /// 🔹 Fetch Logged-In User Info
  Future<void> _onGetUserInfo(
      GetUserInfoEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    final result = await _getCurrentUserUseCase();

    result.fold(
      (failure) => emit(const UserError(message: "Failed to fetch user info")),
      (user) => emit(UserLoaded(user: user)), // ✅ Store user info in state
    );
  }
}
