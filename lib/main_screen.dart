import 'package:flutter/material.dart';
import 'package:zawj_app/chatgroup.dart';
import 'package:zawj_app/constant/app_color.dart';
import 'package:zawj_app/homepage.dart';
import 'package:zawj_app/profilpage.dart';
import 'package:zawj_app/riwayatpage.dart';
import 'package:zawj_app/serasi.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    Riwayatpage(),
    Serasipage(),
    Chatgrouppage(),
    Profilpage(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: AppColor.pinktua,
        unselectedItemColor: AppColor.abutua,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_empty),
            activeIcon: Icon(Icons.hourglass_full),
            label: 'riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            activeIcon: Icon(Icons.favorite),
            label: 'serasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'profil',
          ),
        ],
      ),
    );
  }
}
