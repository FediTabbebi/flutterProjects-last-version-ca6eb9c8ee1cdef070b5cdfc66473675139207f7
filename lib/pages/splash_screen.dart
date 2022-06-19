import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iblaze/pages/CLient/ClientPage.dart';
import 'package:iblaze/pages/Conductor/LoginAs.dart';
import '../data/globals.dart';
import '../services/conductorServices/Register_Login_Conductor.dart';
import '../services/userServices/Offre_Api.dart';
import '../services/userServices/Register_Login.dart';
import 'CLient/TruckMachine_page.dart';
import 'CLient/Login_page.dart';
import 'Conductor/VanConductor/conductorPage.dart';
import 'Conductor/conductorLoginAs.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    new Timer(const Duration(milliseconds: 3500), () {
      setState(() {
        Future.delayed(Duration.zero, () async {
          checkIfLoggin();
        });
      });
      //  Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => LoginPage()),
      //       (route) => false);
    });

    new Timer(Duration(milliseconds: 10), () {
      setState(() {
        _isVisible = true;
      });
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance
  //       ?.addPostFrameCallback((_) => APIOffreUser.GetFreight());
  // }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,child) => SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0,
              duration: Duration(milliseconds: 1750),
              child: Center(
                child: Container(
                  height: 160.0.h,
                  width: 160.0.w,
                  child: Center(
                    child: ClipOval(
                      child:
                          Hero(tag: "blaze", child: Image.asset('images/Lg.png')),
                    ),
                  ),
                  decoration: BoxDecoration(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void checkIfLoggin() async {
  await APIServiceUser.login(userData.read("email"), userData.read("password"));
  print(userData.read("email"));
  print(userData.read("password"));
  print(checkLogin);

  if (checkLogin && currentUser?.Status == "active") {
    APIServiceConductor.LoginConductor(
        userData.read("email"), userData.read("password"));
    Get.off(() => LoginChoices());
  } else if (checkLogin &&
      (currentUser?.Status == "pending" ||
          currentUser?.Status == "rejected" ||
          currentUser?.Status == "deleted" ||
          currentUser?.Status == "none")) {
    Get.off(() => ClientPage(index: 0));
  } else {
    Get.off(() => LoginPage());
  }
}
