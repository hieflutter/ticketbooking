import 'package:flutter/material.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';

Widget customButton(

  VoidCallback onPressed,
  String buttontexts
) {
  return SizedBox(
    width: ScreenSizeConfig.ScreenWidth * 0.5,
    height: ScreenSizeConfig.ScreenHeight * 0.054,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ScreenSizeConfig.primarycolor,
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white, // White text color
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: ScreenSizeConfig.customwhite, // Border color
            width: 1.0, // Border width
          ),
        ),
      ),
      child: Text(
        buttontexts,style: buttontext,
      ),
    ),
  );
}
