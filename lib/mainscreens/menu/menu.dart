// import 'dart:ffi' as ffi;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/custom/customappbarwithoutback.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';

import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/History.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/changepassword.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/profile.dart';
import 'package:ticketbooking/onbording/login.dart';
import 'package:ticketbooking/onbording/onbording.dart';
import 'package:ticketbooking/onbording/splashcreen.dart';
import 'package:ticketbooking/responsive/responsive.dart';

class menupage extends StatefulWidget {
  const menupage({super.key});

  @override
  State<menupage> createState() => _menupageState();
}

class _menupageState extends State<menupage> {
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    final preferredSize = Responsive.isTablet(context)
        ? ScreenSizeConfig.ScreenWidth * 0.1
        : ScreenSizeConfig.ScreenWidth * 0.15;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child:
                customappbarwithoutback(customappbarwithoutbacktittle: "Menu")),
        body: Container(
          color: Color(0xffF2F2F2),
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      customContainer(
                        [
                          custlist("Profile", CupertinoIcons.profile_circled, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile(), // Replace with your target screen
                              ),
                            );
                          }),
                          customsizebox(),
                          custlist("Change Password", CupertinoIcons.lock_shield,
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    changepassword(), // Replace with your target screen
                              ),
                            );
                          }),
                        ],
                      ),
                      SizedBox(height: 20),
                      customContainer(
                        [
                          custlist("Booking list", CupertinoIcons.square_list,
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookingHistoryScreen(), // Replace with your target screen
                              ),
                            );
                          }),
                          customsizebox(),
                          custlist("Notifications", CupertinoIcons.bell, () {}),
                          customsizebox(),
                          custlist("Offers", CupertinoIcons.tags, () {}),
                          customsizebox(),
                          custlist("Customer Service", Icons.headset_mic_outlined,
                              () {}),
                          customsizebox(),
                          custlist(
                              "Feed Back", Icons.question_answer_outlined, () {}),
                        ],
                      ),
                      SizedBox(height: 20),
                      customContainer(
                        [
                          custlist("Sign Out", Icons.login, () async {
                            var shredpref = await SharedPreferences.getInstance();
                            setState(() {
                              shredpref.setBool(SplashcreenState.KEYLOGIN, false);
                
                              shredpref.remove('booking_history');
                               shredpref.remove('Username');
                                shredpref.remove('Email');
                                 shredpref.remove('Mobile');
                
                         
                       
                     
                  
                            });
                
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    loginpage(), // Replace with your target screen
                              ),
                            );
                          }),
                        ],
                      ),
                    ]),
              )),
        ));
  }

  Widget customsizebox() {
    return SizedBox(height: 15);
  }

  Widget custlist(String cuxtomtext, IconData icons, VoidCallback onPressed) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icons, color: Color(0xff555555)),
            SizedBox(width: 5),
            Text(
              cuxtomtext,
              style: subtittletext,
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: ScreenSizeConfig.iconSize * .7,
                      color: Color(0xff555555),
                    )),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget customContainer(List<Widget> children) {
    return Container(
        decoration: BoxDecoration(
          color: ScreenSizeConfig.customwhite,
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.all(14.0),
        child: Column(children: children));
  }
}
