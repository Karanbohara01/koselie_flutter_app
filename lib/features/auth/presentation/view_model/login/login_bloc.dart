import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:koselie/features/home/presentation/view/home_view.dart';
import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _registerBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );
    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginUserEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          LoginParams(
            username: event.username,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            showMySnackBar(
              context: event.context,
              message: "Login Successful",
              color: Colors.green,
            );
            add(
              NavigateHomeScreenEvent(
                context: event.context,
                destination: const HomeView(),
              ),
            );
            // _homeCubit.setToken(token);
          },
        );
      },
    );
  }
}

// // for testing only
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/domain/usecase/login_user_usecase.dart';
// import 'package:koselie/features/home/presentation/view_model/home_cubit.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final HomeCubit _homeCubit;
//   final LoginUseCase _loginUseCase;

//   LoginBloc({
//     required HomeCubit homeCubit,
//     required LoginUseCase loginUseCase,
//   })  : _homeCubit = homeCubit,
//         _loginUseCase = loginUseCase,
//         super(LoginState.initial()) {
//     on<LoginUserEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true));

//       final result = await _loginUseCase(
//         LoginParams(username: event.username, password: event.password),
//       );

//       result.fold(
//         (failure) {
//           emit(state.copyWith(isLoading: false, isSuccess: false));
//           // Emitting error event for snackbar
//           add(const ShowSnackbarEvent(message: "Invalid Credentials"));
//         },
//         (token) {
//           emit(state.copyWith(isLoading: false, isSuccess: true));
//           // Emitting success event for snackbar
//           add(const ShowSnackbarEvent(message: "Login Successful"));
//           // Emitting navigation event to Home screen
//           add(NavigateToHomeEvent());
//         },
//       );
//     });

//     on<ShowSnackbarEvent>((event, emit) {
//       // This event will be handled by the UI layer to show snackbar
//     });

//     on<NavigateToHomeEvent>((event, emit) {
//       // This event will be handled by the UI layer to navigate to the home screen
//     });
//   }
// }
