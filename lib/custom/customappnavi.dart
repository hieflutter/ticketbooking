import 'package:flutter/material.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/custom/Customeroutenavigation.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/mainscreens/menu/menu.dart';

class customappbarnavi extends StatefulWidget {
  String customappbarnavitittle;
  customappbarnavi({super.key, required this.customappbarnavitittle});

  @override
  State<customappbarnavi> createState() => _customappbarnaviState();
}

class _customappbarnaviState extends State<customappbarnavi> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: ScreenSizeConfig.primarycolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              // pushReplacement(
              //                         context,
              //                         SwiperPageRoute(
              //                           builder: (context) => BottomNavigationBarWidget(),
              //                           direction: SwiperPageRouteDirection
              //                               .leftToRight,
              //                         ),
              //                       );
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: ScreenSizeConfig.customwhite,
              size: 20,
            )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          widget.customappbarnavitittle,
          style: appbartittle,
        ));
  }
}
