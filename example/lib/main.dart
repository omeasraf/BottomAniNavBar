import 'package:flutter/material.dart';
import 'package:bottom_ani_nav_bar/bottom_ani_nav_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.blueAccent);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            top: false,
            child: IndexedStack(index: _currentIndex, children: [
              Scaffold(
                  body: Center(
                      child: Text(
                "Home Page",
                style: textStyle,
              ))),
              Scaffold(
                  body: Center(
                      child: Text(
                "Search Page",
                style: textStyle,
              ))),
              Scaffold(
                  body: Center(
                      child: Text(
                "Time Page",
                style: textStyle,
              ))),
              Scaffold(
                  body: Center(
                      child: Text(
                "Settings Page",
                style: textStyle,
              ))),
            ]),
          ),
          bottomNavigationBar: BottomAniNavBar(
              unselectedItemColor: Colors.red,
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text(
                    'Home',
                    style: textStyle,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text(
                    'Search',
                    style: textStyle,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.timelapse),
                  title: Text(
                    'Time',
                    style: textStyle,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: textStyle,
                  ),
                ),
              ]),
        ));
  }
}
