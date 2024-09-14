import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticketbooking/Components/Customloading.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/mainscreens/Dashbord/dashbord.dart';
import 'package:ticketbooking/mainscreens/menu/menu.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/Help.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/History.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/changepassword.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/profile.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Dashbord(),
    BookingHistoryScreen(),
    //  const changepassword(),
    Help(),
    const menupage(),
  ];

  Color bottomNavbarColor = const Color.fromARGB(255, 141, 140, 140);
  Color selectedIconColor = const Color.fromARGB(255, 229, 205, 157);
  Color cardColor = const Color.fromARGB(255, 41, 40, 40);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: ScreenSizeConfig.customwhite,
        selectedItemColor: ScreenSizeConfig.primarycolor,
        unselectedItemColor: ScreenSizeConfig.primarycolor,
        iconSize: 24,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
            label: 'Menu',
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

