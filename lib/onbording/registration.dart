import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking/Databasehelper/databasehelper.dart';
import 'package:ticketbooking/custom/Customeroutenavigation.dart';
import 'package:ticketbooking/custom/custombutton.dart';
import 'package:ticketbooking/custom/customtextformfiled.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/onbording/login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode mobileFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode cPasswordFocusNode = FocusNode();

  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;
  String? passwordErrorText;
  void _submit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String Username = userNameController.text;
      String Email = emailController.text;
      String Mobile = mobileController.text;
      String Password = passwordController.text;
      String ConfirmPassword = cPasswordController.text;

      if (Password != ConfirmPassword) {
        // check that password and confirm password match or if match then submit otherwise show toast message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Passwords do not match',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ));
        return;
      }

      Map<String, dynamic> userData = {
        'Username': Username,
        'EmailId': Email,
        'MobileNo': int.parse(Mobile.substring(3)),
        'password': Password,
      };
      int userId = await DatabaseHelper.instance.insert(userData);

      if (userId > 0) {
        // in that condition check that user inserted our data or not
        print('User inserted with ID: $userId');
        // Navigator.pop(context);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('Username', Username);
        await prefs.setString('Email', Email);
        await prefs.setString('Mobile', Mobile);
        await prefs.setString('Password', Password);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginpage(),
          ),
        );
      } else {
        print('Failed to insert user data');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenSizeConfig.customgrey,
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  //height: ScreenSizeConfig.ScreenHeight ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 180,
                          child: AppBar(
                            centerTitle: true,
                            backgroundColor: ScreenSizeConfig.primarycolor,
                            leading: Icon(null),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30),
                              ),
                            ),
                          )),
                      Container(
                        height: ScreenSizeConfig.ScreenHeight / 1.7,
                        margin: EdgeInsets.only(top: 50, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Container()

                            customtextformfiled(
                              controller: userNameController,
                              hintText: 'Username',
                              iconData: Icons.person,
                              focusNode: userNameFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(emailFocusNode);
                              },
                            ),
                            customtextformfiled(
                              controller: emailController,
                              hintText: 'Email',
                              iconData: Icons.email,
                              focusNode: emailFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(mobileFocusNode);
                              },
                            ),
                            customtextformfiled(
                              controller: mobileController,
                              hintText: 'Mobile',
                              iconData: Icons.phone,
                              focusNode: mobileFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                            ),
                            customtextformfiled(
                              controller: passwordController,
                              hintText: 'Password',
                              iconData: Icons.password,
                              isPassword: true,
                              focusNode: passwordFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(cPasswordFocusNode);
                              },
                            ),
                            customtextformfiled(
                              controller: cPasswordController,
                              hintText: 'Re-Password',
                              iconData: Icons.password,
                              isPassword: true,
                              focusNode: cPasswordFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                if (passwordController.text !=
                                    cPasswordController.text) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              },
                              onSuffixTap: () {
                                setState(() {
                                  isCPasswordVisible = !isCPasswordVisible;
                                });
                              },
                            ),
                            if (passwordErrorText != null)
                              Text(
                                passwordErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            customButton(() {
                              _submit();
                            }, "Sign Up"),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontFamily:
                                        ScreenSizeConfig.fontfamilyRegular,
                                    color: ScreenSizeConfig.customblack,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        ScreenSizeConfig.ScreenWidth * .045,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      SwiperPageRoute(
                                        builder: (context) => loginpage(),
                                        direction: SwiperPageRouteDirection
                                            .leftToRight,
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Text(
                                    " Sign in",
                                    style: subtittletextindigo,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 130,
                right: 130,
                child: Container(
                 height: 90,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ScreenSizeConfig.customwhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset("assets/Image/logo.png"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
