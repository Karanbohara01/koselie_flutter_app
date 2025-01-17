import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/home/presentation/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index, isDarkTheme: false));
  }

  void toggleTheme(bool value) {}

  void logout() {}
}
