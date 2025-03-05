import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view/user_profile_view.dart';
import 'package:koselie/features/chat/presentation/view/list_of_users_view.dart';
import 'package:koselie/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:koselie/features/posts/presentation/view/create_post_view.dart';
import 'package:koselie/features/posts/presentation/view/get_all_posts_view.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // List of bottom navigation screens
  final List<Widget> _bottomScreens = [
    const DashboardScreen(),
    const CreatePostView(),
    const PostView(),
    // CategoryView(),
    const UserListScreen(),
    const UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        // Define colors based on theme
        //final backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white; // Not used here
        //final textColor = isDarkMode ? Colors.white : Colors.black; // Not used here
        final bottomNavBarGradient = isDarkMode
            ? [Colors.black87, Colors.black54]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];

        const selectedItemColor = Colors.white;
        const unselectedItemColor = Colors.white70;

        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                _bottomScreens[_selectedIndex], // Display the selected screen
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: bottomNavBarGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: unselectedItemColor,
                showUnselectedLabels: false,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outline),
                    label: 'Post',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.storefront),
                    label: 'Market',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.category),
                  //   label: 'Category',
                  // ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.message),
                    label: 'Chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
