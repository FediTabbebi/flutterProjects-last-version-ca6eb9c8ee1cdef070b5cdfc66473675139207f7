import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/CLient/Login_page.dart';
import 'package:iblaze/pages/Conductor/VanConductor/SubmittedOffers.dart';
import 'package:iblaze/pages/Conductor/VanConductor/HomePage.dart';
import '../AcceptedOffers.dart';
import 'RejectedOffers.dart';
import 'SideBar/NavigationDrawerConductor.dart';

class VanConductor extends StatefulWidget {
  int index;
  VanConductor({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<VanConductor> createState() => _VanConductorState(index);
}

class _VanConductorState extends State<VanConductor> {
  _VanConductorState(this.index);
  int index = 0;

  final screens = [
    HomePage(),
    conductorRegisteredOffers(),
    AcceptedOffers(),
    RejectedOffers()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,child) => SafeArea(
        child: Scaffold(
          body: screens[index],
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              height: 45.h,
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(TextStyle(
                  fontSize: 10.h,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,), ),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
            ),
            child: NavigationBar(
                backgroundColor: Color(0xFF005b71),
                selectedIndex: index,
                //animationDuration: Duration(seconds: 2),
                onDestinationSelected: (index) =>
                    setState(() => this.index = index),
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home, color: Colors.white, size: 20.h.w),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.email, color: Colors.white, size: 20.h.w),
                    label: 'Propositions',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.check, color: Colors.white, size: 20.h.w),
                    label: 'Accepted Props',
                  ),
                  NavigationDestination(
                    icon: Icon(FontAwesomeIcons.xmark,
                        color: Colors.white, size: 20.h.w),
                    label: 'Declined Props',
                  )
                ]),
          ),
          drawer: const NavigationDrawerConduct(),
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Color(0xFF005b71)),
                      ),
                      onTap: () {
                        userData.remove("password");
                        userData.remove("email");

                        WidgetsBinding.instance!.addPostFrameCallback(
                          (_) {
                            Get.offAll(LoginPage());
                          },
                        );
                      })
                ],
              )
            ],
           
            backgroundColor: Color(0xFF005b71),
          ),
        ),
      ),
    );
  }
}
