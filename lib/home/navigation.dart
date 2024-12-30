import 'package:flutter/material.dart';
import 'package:healty_apps/account/account.dart';
import 'package:healty_apps/constant/font_const.dart';
import 'package:healty_apps/home/home.dart';
import 'package:healty_apps/news/news.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedTab = 0;
  final List _pages = [
    const HomePage(),
    const NewsPage(),
    const AccountPage(),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
              size: 25,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.black,
              size: 25,
            ),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.newspaper_outlined,
              color: Colors.black,
              size: 25,
            ),
            activeIcon: Icon(
              Icons.newspaper,
              color: Colors.black,
              size: 25,
            ),
            label: "Cuti",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 25,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colors.black,
              size: 25,
            ),
            label: "Akun",
          ),
        ],
        mouseCursor: SystemMouseCursors.grab,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        selectedIconTheme: const IconThemeData(color: Colors.black, size: 25),
        selectedItemColor: Colors.black,
        selectedLabelStyle: kfBlack12Bold,
        unselectedFontSize: 12,
        unselectedIconTheme: const IconThemeData(color: Colors.black, size: 25),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: kfBlack12Regular,
        currentIndex: _selectedTab,
        onTap: (int idx) => _changeTab(idx),
      ),
    );
  }
}
