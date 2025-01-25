import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/domain/usecase/register_user_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterBloc({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _registerUseCase.call(RegisterUserParams(
      username: event.username,
      password: event.password,
      email: event.email,
    ));

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true));
      showMySnackBar(context: event.context, message: "Signup successful");
    });
  }
}
