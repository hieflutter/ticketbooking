import 'package:flutter/material.dart';
import 'package:ticketbooking/Components/Customloading.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/custom/Customeroutenavigation.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'dart:async';

import 'package:ticketbooking/mainscreens/Dashbord/dashbord.dart';
import 'package:ticketbooking/onbording/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  final List<OnboardingModel> _onboardingPages = [
    OnboardingModel(
      title: 'Welcome to Bus Travel!',
      description: 'Plan your next bus journey with ease.',
      image: 'assets/Image/onbordone.png',
    ),
    OnboardingModel(
      title: 'Find Your Perfect Route',
      description:
          'Search for routes, compare prices, and find the best deals.',
      image: 'assets/Image/onbordingtwo.png',
    ),
    OnboardingModel(
      title: 'Book Your Tickets Online',
      description:
          'Secure your tickets in just a few clicks and enjoy a seamless experience.',
      image: 'assets/Image/onbordingtree.png',
    ),
    OnboardingModel(
      title: 'Relax and Enjoy the Ride',
      description: 'Sit back, relax, and enjoy your comfortable journey.',
      image: 'assets/Image/onbodingfour.png',
    ),
    
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _onboardingPages.length - 1) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        );
      } else {
        _stopAutoScroll();
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    return Scaffold(
      // backgroundColor: ScreenSizeConfig.primarycolor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  if (_currentPage == _onboardingPages.length - 1) {
                    _stopAutoScroll();
                  }
                },
                itemCount: _onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: _onboardingPages[index].title,
                    description: _onboardingPages[index].description,
                    image: _onboardingPages[index].image,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _onboardingPages.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        width: _currentPage == index ? 16.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? ScreenSizeConfig.primarycolor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  if (_currentPage == _onboardingPages.length - 1)
                    customElevatedButton(Text("Get Started", style: buttonText),
                        () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        SwiperPageRoute(
                          builder: (context) => loginpage(),
                          direction: SwiperPageRouteDirection.leftToRight,
                        ),
                        (Route<dynamic> route) =>
                            false, 
                      );
                    })
                  else
                    customElevatedButton(
                        Text(
                          "Skip",
                          style: buttonText,
                        ), () {
                      _stopAutoScroll();

                      _pageController.jumpToPage(_onboardingPages.length - 1);
                    })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customElevatedButton(final Widget child, VoidCallback onpressed) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ScreenSizeConfig.primarycolor,
        foregroundColor: ScreenSizeConfig.customwhite,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        textStyle: const TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, inherit: false),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: child,
    );
  }
}

class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 350.0,
            width: 300.0,
          ),
          const SizedBox(height: 20.0),
          Text(title, style: tittletext, textAlign: TextAlign.center),
          const SizedBox(height: 5.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: subtittletext,
          ),
        ],
      ),
    );
  }
}
