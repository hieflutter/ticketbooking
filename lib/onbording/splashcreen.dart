import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/custom/Customeroutenavigation.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/mainscreens/Dashbord/dashbord.dart';
import 'package:ticketbooking/onbording/login.dart';
import 'package:ticketbooking/onbording/onbording.dart';

class Splashcreen extends StatefulWidget {
  const Splashcreen({super.key});

  @override
  State<Splashcreen> createState() => SplashcreenState();
}

class SplashcreenState extends State<Splashcreen> {
  static const String KEYLOGIN = "loginkey";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showWelcomeNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Increment the installation counter
    int installationCount = (prefs.getInt('installation_count') ?? 0) + 1;
    prefs.setInt('installation_count', installationCount);

    // Check if it's the first installation for this user
    if (installationCount == 1) {
      // Show welcome notification
      await _showWelcomeNotification();
    }
  }

  Future<void> _showWelcomeNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'welcomebro', // Change this to a unique channel ID
      'Welcome Notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Welcome to My App!', // Notification title
      'Thank you for installing our app. Enjoy exploring!', // Notification body
      platformChannelSpecifics,
    );
  }

  @override
  void initState() {
    super.initState();
    showWelcomeNotification();
    whereToGo();
  }

  void whereToGo() async {
    var sharedpref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedpref.getBool(KEYLOGIN);

    if (isLoggedIn != null && mounted) {
      if (isLoggedIn == false) {
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.pushReplacement(
              context,
              SwiperPageRoute(
                builder: (context) => OnboardingScreen(),
                direction: SwiperPageRouteDirection.bottomToTop,
              ),
            );
          },
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationBarWidget(),
          ),
        );
      }
    } else {
      Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    return Container(
      height: ScreenSizeConfig.ScreenHeight,
      width: ScreenSizeConfig.ScreenWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Image/splash.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Make sure the background is transparent
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenSizeConfig.ScreenHeight * 0.17,
              horizontal: ScreenSizeConfig.ScreenWidth * 0.04),
          child: Column(
            children: [
              Text(
                "Ride the Pulse, Discover the Path",
                style: TextStyle(
                  color: ScreenSizeConfig.customwhite,
                  fontFamily: ScreenSizeConfig.fontfamilytittle,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontSize: ScreenSizeConfig.ScreenWidth * 0.09,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
