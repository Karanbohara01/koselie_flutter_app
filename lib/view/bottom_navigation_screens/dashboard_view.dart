import 'package:flutter/material.dart';
import 'package:koselie/view/bottom_navigation_screens/About.dart';
import 'package:koselie/view/bottom_navigation_screens/home_view.dart';
import 'package:koselie/view/bottom_navigation_screens/market_view.dart';
import 'package:koselie/view/bottom_navigation_screens/profile_view.dart';

class MyDashboardView extends StatefulWidget {
  const MyDashboardView({super.key});

  @override
  State<MyDashboardView> createState() => _MyDashboardViewState();
}

class _MyDashboardViewState extends State<MyDashboardView> {
  int _selectedIndex = 0;
  List<Widget> lstBOttomScreen = [
    const HomeScreen(),
    const MarketScreen(),
    const ProfileScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
          ),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: lstBOttomScreen[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.pink,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
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
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
