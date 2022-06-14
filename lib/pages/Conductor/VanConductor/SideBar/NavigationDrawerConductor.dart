import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/Conductor/VanConductor/SideBar/drawer_items.dart';
import 'package:iblaze/pages/Conductor/VanConductor/sideBar_pages/ConductorProfile.dart';
import 'package:iblaze/pages/Conductor/VanConductor/sideBar_pages/RentHistory.dart';
import 'package:iblaze/pages/Conductor/VanConductor/sideBar_pages/support.dart';

import '../../../CLient/SideBar/Sidebar_pages/about.dart';
import '../VehicleManagement.dart';

class NavigationDrawerConduct extends StatelessWidget {
  const NavigationDrawerConduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context,child) => Drawer(
              child: Material(
                color: Color(0xFF005b71),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                         begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(62, 0, 90, 113),
                              Color.fromARGB(62, 255, 255, 255),
                            ]),
                      ),
                      child: headerWidget(
                        onClicked: () => onItemPressed(context, index: 4),
                      ),
                    ),
                    SizedBox(height: 40),
                    DrawerItem(
                        name: 'Vehicle management',
                        icon: FontAwesomeIcons.truck,
                        onPressed: () => onItemPressed(context, index: 0)),
                    SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                        name: 'History',
                        icon: Icons.lock_clock,
                        onPressed: () => onItemPressed(context, index: 1)),
                    SizedBox(
                      height: 30,
                    ),
                    DrawerItem(
                        name: 'Support',
                        icon: Icons.supervisor_account,
                        onPressed: () => onItemPressed(context, index: 2)),
                    SizedBox(
                      height: 30.h,
                    ),
                    DrawerItem(
                        name: 'About',
                        icon: FontAwesomeIcons.circleExclamation,
                        onPressed: () => onItemPressed(context, index: 3)),
                    SizedBox(
                      height: 100.h,
                    ),
                  ],
                ),
              ),
            ));
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Get.to(() => VehicleManagement());
        break;
      case 1:
        Get.to(() => RentHistory());
        break;
      case 2:
        Get.to(() => Support());
        break;
      case 3:
        Get.to(() => About());
        break;

      case 4:
        Get.to(() => ConductorProfile());
        break;
    }
  }
}

String textEditing({required String Text}) {
  String newText = "";
  if (Text.length > 5) {
    for (var i = 0; i < 5; i++) {
      newText = newText + Text[i];
    }
    newText = newText + "..";
  } else
    newText = Text;
  return newText;
}


  Widget headerWidget({
    required VoidCallback onClicked,
  }) =>
      InkWell(
          hoverColor: Colors.transparent,
          onTap: onClicked,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: 30),
                Container(
                     decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                               color: Colors.white,
                                width: 0.3,
                              )),
                  // color: Color(0xFFE40613),
                  child: Image.asset(
                    "images/conductor.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  //color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(textEditing(Text: "${currentConductor?.conductorName}"),
                          style: GoogleFonts.roboto(
                              fontSize: 30,fontWeight: FontWeight.bold,letterSpacing: 5.0,
                             // color: Color(0xFFF7B30c)
                            //  color: Color(0xFF005b71),
                            color:Colors.white,
                            )),
                      Text("view profile",
                          style: GoogleFonts.roboto(
                            //fontSize: 15,
                            color: Colors.white,
                           // color: Color(0xFF005b71),
                          )),
                    ],
                  ),
                ),
              ]));
