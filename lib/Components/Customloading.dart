import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class AnimationLoading {
  show(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
              height: 100,
              child: 
               CircularProgressIndicator(
         color: Colors.amber,// Change to your desired color
        ),
              // LottieBuilder.asset(
              //   "assets/lottie/cow.json",
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
        );
      },
    );
  }

  stop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
