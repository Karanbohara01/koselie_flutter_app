// // settings_view.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_event.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

// class SettingsView extends StatelessWidget {
//   const SettingsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         final isDarkMode = themeState is DarkThemeState;
//         final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
//         final textColor = isDarkMode ? Colors.white : Colors.black;
//         final appBarGradient = isDarkMode
//             ? [Colors.black87, Colors.black54]
//             : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];

//         Color switchActiveColor =
//             isDarkMode ? Colors.grey : Colors.white; // Define switch color

//         return Scaffold(
//           appBar: AppBar(
//             title: Text("Settings",
//                 style: GoogleFonts.poppins(color: Colors.white)),
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: appBarGradient,
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.logout, color: Colors.white),
//                 onPressed: () => _showLogoutConfirmationDialog(context),
//               ),
//             ],
//           ),
//           body: Container(
//             color: backgroundColor,
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Dark Mode",
//                         style: GoogleFonts.poppins(
//                             color: textColor, fontSize: 18)),
//                     Switch(
//                       value: isDarkMode,
//                       activeColor: switchActiveColor, // Apply switch color
//                       onChanged: (value) {
//                         context.read<ThemeBloc>().add(ToggleThemeEvent());
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showLogoutConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Confirm Logout"),
//           content: const Text("Are you sure you want to log out?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 context
//                     .read<AuthBloc>()
//                     .add(AuthLogoutRequested()); // Trigger logout
//               },
//               child: const Text("Logout"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_event.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;
        final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final appBarGradient = isDarkMode
            ? [Colors.black87, Colors.black54]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];

        Color switchActiveColor = isDarkMode ? Colors.grey : Colors.blueAccent;

        return Scaffold(
          appBar: AppBar(
            title: Text("Settings",
                style: GoogleFonts.poppins(color: Colors.white)),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: appBarGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () => _showLogoutConfirmationDialog(context),
              ),
            ],
          ),
          body: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        isDarkMode
                            ? "Light Mode"
                            : "Dark Mode", // Changed text here
                        style: GoogleFonts.poppins(
                            color: textColor, fontSize: 18)),
                    Switch(
                      value: isDarkMode,
                      activeColor: switchActiveColor,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Text("Confirm Logout",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color)),
          content: Text("Are you sure you want to log out?",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
