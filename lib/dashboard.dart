import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/module_page.dart';
import 'pages/profile_page.dart';
import 'login/login_page.dart';
import 'navbars/top_nav_bar.dart';
import 'navbars/bottom_nav_bar.dart';
import 'menu_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  bool _isMenuOpen = false;

  void _onItemTapped(int index) {
    if (index == 3) {
      _showLogoutDialog();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _openMenu() {
    setState(() {
      _isMenuOpen = true;
    });
  }
  void _closeMenu() {
    setState(() {
      _isMenuOpen = false;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        selectedIndex: _selectedIndex,
        onMenuPressed: _openMenu,
      ),
      body: Stack(
        children: [
          _buildBody(), 
          
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _isMenuOpen ? 0 : -MediaQuery.of(context).size.width ,
            top: 0,
            bottom: 0,
            child: MenuPage(onClose: _closeMenu),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    return [
      const HomePage(),
      ModulePage(),
      const ProfilePage(),
    ][_selectedIndex];
  }
}
