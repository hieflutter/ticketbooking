import 'package:flutter/material.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/custom/customappbarwithoutback.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/mainscreens/menu/menuitmes/ChatSupportPage.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width > 600 ? 8 : 11;
    double appBarFontSize = MediaQuery.of(context).size.width > 600 ? 15 : 17;
    ScreenSizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child:customappbarwithoutback(customappbarwithoutbacktittle: "Help")
        
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          // height: ScreenSizeConfig.ScreenHeight,
          // width: ScreenSizeConfig.ScreenWidth,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Designed and Developed by',
                style: TextStyle(
                    fontFamily: ScreenSizeConfig.fontfamilytittle,
                    color: ScreenSizeConfig.primarycolor,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenSizeConfig.ScreenWidth * .05),
              ),
              SizedBox(height: ScreenSizeConfig.ScreenHeight * 0.01),
              Text('hieflutter', style: subtittletext),
              SizedBox(height: ScreenSizeConfig.ScreenHeight * 0.025),
              Text(
                'Contact Us',
                style: TextStyle(
                    fontFamily: ScreenSizeConfig.fontfamilytittle,
                    color: ScreenSizeConfig.primarycolor,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenSizeConfig.ScreenWidth * .05),
              ),
              SizedBox(height: ScreenSizeConfig.ScreenHeight * 0.01),

              custometextwithicon("9999999999", Icons.phone),
              SizedBox(height: ScreenSizeConfig.ScreenHeight * 0.01),
              custometextwithicon(
                "hieflutter@gmail.com",
                Icons.email,
              ),
              SizedBox(height: ScreenSizeConfig.ScreenHeight / 2.2),
              // Center(
              //     child: Image.asset(
              //   'assets/Image/chat.png',
              //   height: 290,
              //   width: 290,
              // )),

              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ChatSupportPage()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: ScreenSizeConfig.primarycolor,
                    child: Icon(
                      Icons.chat,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget custometextwithicon(String text, IconData icondata) {
  return Row(
    children: [
      Icon(
        icondata,
        color: Colors.black,
        size: ScreenSizeConfig.ScreenWidth * 0.055,
      ),
      SizedBox(
        width: ScreenSizeConfig.ScreenWidth * 0.04,
      ),
      Text(text, style: subtittletext),
    ],
  );
}
