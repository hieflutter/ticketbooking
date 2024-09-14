import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking/Components/bottomnavigationbar.dart';
import 'package:ticketbooking/Databasehelper/databasehelper.dart';
import 'package:ticketbooking/Model/usermodel.dart';
import 'package:ticketbooking/custom/Customeroutenavigation.dart';
import 'package:ticketbooking/custom/custombutton.dart';
import 'package:ticketbooking/custom/customtextformfiled.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';
import 'package:ticketbooking/onbording/login.dart';
import 'package:ticketbooking/onbording/registration.dart';
import 'package:ticketbooking/onbording/splashcreen.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
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

  void _handleLogin() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      UserModel? user = await DatabaseHelper.instance.getUser(email, password);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Welcome',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ));
        var shredpref = await SharedPreferences.getInstance();
        shredpref.setBool(SplashcreenState.KEYLOGIN, true);
        Navigator.pushAndRemoveUntil(
          context,
          SwiperPageRoute(
            builder: (context) => BottomNavigationBarWidget(),
            direction: SwiperPageRouteDirection.leftToRight,
          ),
          (Route<dynamic> route) => false,
        );
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => BottomNavigationBarWidget()),
        // );
      } else {
        // User does not exist or incorrect credentials, show an error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Invalid email or password',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ));
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
                        height: ScreenSizeConfig.ScreenHeight / 3.4,
                        margin: EdgeInsets.only(top: 100, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Container()

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

                            if (passwordErrorText != null)
                              Text(
                                passwordErrorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            customButton(() {
                              // if (_formKey.currentState!.validate()) {
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => loginpage(),
                              //     ),
                              //   );
                              // }
                              _handleLogin();
                            }, "Sign in"),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Don't have an account?",
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
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Registration(),
                                    //   ),
                                    // );
                                    Navigator.push(
                                      context,
                                      SwiperPageRoute(
                                        builder: (context) => Registration(),
                                        direction: SwiperPageRouteDirection
                                            .leftToRight,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    " Sign up",
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
                top: 130,
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
