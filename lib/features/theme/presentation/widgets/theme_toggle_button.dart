import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc.dart';
import '../bloc/theme_event.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.brightness_6), // Light/Dark icon
      onPressed: () {
        context.read<ThemeBloc>().add(ToggleThemeEvent());
      },
    );
  }
}
