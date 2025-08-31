import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mastermindv/Components/Developer/Developer.dart';
import 'package:mastermindv/Components/Home.dart';
import 'package:mastermindv/Components/Home/Rule.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [Home(), Rule(), Developer()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color:  const Color(0xFFF4B975),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GNav(
            rippleColor: Colors.grey[800]!,
            hoverColor: Colors.grey[700]!,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            tabShadow: [
              BoxShadow(
                color: const Color.fromARGB(
                  255,
                  250,
                  192,
                  192,
                ).withOpacity(0.5),
                blurRadius: 8,
              ),
            ],
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 900),
            gap: 8,
            color: Colors.grey[800],
            activeColor: const Color(0xFF9C4E00),
            iconSize: 44,
            tabBackgroundColor: const Color.fromARGB(
              0,
              155,
              39,
              176,
            ).withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.rule_sharp, text: 'Rules'),
              GButton(icon: Icons.person, text: 'Dev'),
            ],
            onTabChange: (index) {
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
