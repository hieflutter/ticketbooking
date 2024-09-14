import 'package:flutter/material.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';

class customappbar extends StatefulWidget {
  String customappbartittle;
  customappbar({super.key, required this.customappbartittle});

  @override
  State<customappbar> createState() => _customappbarState();
}

class _customappbarState extends State<customappbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: ScreenSizeConfig.primarycolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
         widget. customappbartittle,
          style: appbartittle,
        ));
  }
}
