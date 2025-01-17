import 'package:flutter/material.dart';
import 'package:koselie/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:koselie/features/market/market_view.dart';
import 'package:koselie/features/profile/profile_view.dart';
import 'package:koselie/features/search/search_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  // List of bottom navigation screens
  List<Widget> lstBOttomScreen = [
    const DashboardScreen(),
    const MarketScreen(),
    const ProfileScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: lstBOttomScreen[_selectedIndex], // Display the selected screen
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.pink,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                label: 'Market'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Search'),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index; // Update the index to switch screens
            });
          },
        ),
      ),
    );
  }
}

// Define placeholder screens for Market, Profile, and Search
