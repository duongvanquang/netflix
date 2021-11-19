import 'package:flutter/material.dart';

import 'comingsoon_screen.dart';
import 'dowloadscreen.dart';
import 'gamescreen.dart';
import 'homescreen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  static final List<Widget> _WidgetOption = [
    const HomeScreen(),
    const GameScreen(),
    const ComingSoonScreen(),
    const DowloadScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(child: _WidgetOption.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black87,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded, size: 32), label: 'Home'),
            BottomNavigationBarItem(
                icon: Image(
                    image: const AssetImage('assets/images/game.png'),
                    width: 32,
                    height: 32,
                    color: _selectedIndex == 1 ? Colors.white : Colors.grey),
                label: 'Games'),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_library_outlined,
                  size: 32,
                ),
                label: 'Coming Soon'),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.arrow_circle_down_rounded,
                  size: 32,
                ),
                label: 'Downloads')
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
}
