import 'package:flutter/material.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';

class customappbarwithoutback extends StatefulWidget {
  String customappbarwithoutbacktittle;
  customappbarwithoutback(
      {super.key, required this.customappbarwithoutbacktittle});

  @override
  State<customappbarwithoutback> createState() =>
      _customappbarwithoutbackState();
}

class _customappbarwithoutbackState extends State<customappbarwithoutback> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: ScreenSizeConfig.primarycolor,
        leading: Icon(null),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          widget.customappbarwithoutbacktittle,
          style: appbartittle,
        ));
  }
}
