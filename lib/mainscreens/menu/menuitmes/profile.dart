import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/custom/customappbar.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/responsive/responsive.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, String?> _profileData = {
    'Username': '',
    'Email': '',
    'Mobile': '',
   // 'Address': '',
  };

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileData = {
        'Username': prefs.getString('Username'),
        'Email': prefs.getString('Email'),
        'Mobile': prefs.getString('Mobile'),
        //'Address': '',  
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig.init(context);
    final preferredSize = Responsive.isTablet(context)
        ? ScreenSizeConfig.ScreenWidth * 0.1
        : ScreenSizeConfig.ScreenWidth * 0.15;

    return Scaffold(
      backgroundColor: ScreenSizeConfig.customgrey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(preferredSize),
        child: customappbar(customappbartittle: 'Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 12, right: 12),
          width: ScreenSizeConfig.ScreenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ScreenSizeConfig.customwhite,
          ),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customcardcolumn("Name", _profileData['Username']),
                customcardcolumn("Email", _profileData['Email']),
                customcardcolumn("Phone", _profileData['Mobile']),
               // customcardcolumn("Address", _profileData['Address']),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBarWidget()
    );
  }

  Widget customcardcolumn(String customtext, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          customtext,
          style: subtittletextgrey,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          value ?? '',
          style: subtittletext,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Divider(),
      ],
    );
  }
}