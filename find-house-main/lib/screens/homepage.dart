
import 'package:findhouse/screens/home_searcher/homescreen.dart';
import 'package:findhouse/screens/home_searcher/profile.dart';
import 'package:findhouse/screens/home_searcher/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  List<Widget> tabPages = [

    const HomeScreen(),
   const EditProfilePage(),
    const SettingsPage(),

  ];
  @override
  Widget build(BuildContext context){

          return Scaffold(

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.amber,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home"
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'My Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings',
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                }
                );
              },
            ),
            body: tabPages[_currentIndex],
          );

  }

}
