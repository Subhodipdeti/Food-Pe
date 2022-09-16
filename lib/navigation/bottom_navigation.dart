import 'package:flutter/material.dart';
import 'package:food_pe/screens/home/home.dart';
import 'package:food_pe/screens/profile/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[HomeScreen(), ProfilePage()];

  void onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Colors.white, // <-- This works for fixed
        selectedItemColor: const Color.fromARGB(255, 71, 71, 73),
        unselectedItemColor: const Color.fromARGB(255, 198, 198, 198),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile"),
        ],
        selectedLabelStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14.0),
        unselectedLabelStyle:
            GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14.0),
        currentIndex: _selectedIndex,
        onTap: onTabChange,
      ),
    );
  }
}
