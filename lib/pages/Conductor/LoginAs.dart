import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/CLient/TruckMachine_page.dart';
import 'package:iblaze/pages/Conductor/VanConductor/conductorPage.dart';

import '../../Models/conductorOffers.dart';
import '../../services/conductorServices/conductorOffreAPI.dart';
import '../../services/userServices/Register_Login.dart';
import '../CLient/ClientPage.dart';
import 'VanConductor/RegisterConductorPage1.dart';

class LoginAs extends StatefulWidget {
  const LoginAs({Key? key}) : super(key: key);

  @override
  State<LoginAs> createState() => _LoginAsState();
}

class _LoginAsState extends State<LoginAs> {
  List<AllOffers> offers = [];
  DateTime timeBackPressed = DateTime.now();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    offers = await APIOffreConductor.getAllOffers(
        "${currentUser?.id}", "${currentConductor?.conductorId}");
    userData.write("offersLength", '${offers.length}');
    print(userData.read("offersLength"));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,child) => DoubleBack(
        message: "Press Back again to Exit The App",
        textStyle: TextStyle(fontSize: 15, color: Colors.white),
        //background: Colors.red,
        backgroundRadius: 10,
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                          color: Color(0xFF005b71),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(75),
                              bottomRight: Radius.circular(75)),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 30.w,
                                  right: 30.w,
                                  top: 30.h,
                                  bottom: 30.h,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  /*borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(100)),*/
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => ClientPage(index: 0));
                                    transition:
                                    Transition.fade;
                                  },
                                  child: Image.asset(
                                    "images/userA.png",
                                    height: 160.h,
                                    width: 160.w,
                                  ),
                                ),
                              ),
                              Text(" User",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        )),
                    Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: Colors.white,

                        /* decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF005b71),
                                Color(0xFFFFFFFF),
                              ]),
                          color: Colors.white,
                          /* borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                          ),*/
                        ),*/
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 30.w,
                                  right: 30.w,
                                  top: 30.h,
                                  bottom: 30.h,
                                ),
                                decoration: BoxDecoration(
                                  /*color: Color(0xFF005b71),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF005b71),
                                        Color(0xFFFFFFFF),
                                      ]),*/
                                  shape: BoxShape.circle,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => VanConductor(index: 0));

                                    transition:
                                    Transition.fade;
                                  },
                                  child: Image.asset(
                                    "images/conductor.png",
                                    height: 160.h,
                                    width: 160.w,
                                  ),
                                ),
                              ),
                              Text("Driver",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Color(0xFF005b71),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
