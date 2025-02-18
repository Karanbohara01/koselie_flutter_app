import 'package:flutter/material.dart';
import 'package:koselie/features/auth/presentation/view/user_profile_view.dart';
import 'package:koselie/features/category/presentation/view/category_view.dart';
import 'package:koselie/features/chat/presentation/view/list_of_users_view.dart';
import 'package:koselie/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:koselie/features/posts/presentation/view/create_post_view.dart';
import 'package:koselie/features/posts/presentation/view/get_all_posts_view.dart';

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
    CategoryView(),
    const UserProfileScreen(),
    const UserListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _bottomScreens[_selectedIndex], // Display the selected screen
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E2DE2), // Purple Shade
              Color(0xFFEC008C), // Pink Shade
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          boxShadow: [
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
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
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
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Chat',
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
  }
}
