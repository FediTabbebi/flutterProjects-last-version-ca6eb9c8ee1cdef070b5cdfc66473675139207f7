import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/CLient/SideBar/Sidebar_pages/user_profile.dart';
import '../../../services/conductorServices/Register_Login_Conductor.dart';
import '../../../services/userServices/Register_Login.dart';
import '../../Conductor/VanConductor/RegisterConductorPage1.dart';
import 'Sidebar_pages/RentHistory.dart';
import 'Sidebar_pages/about.dart';
import 'Sidebar_pages/promotions.dart';
import 'Sidebar_pages/support.dart';
import 'drawer_items.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

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
                      name: 'Promotion',
                      icon: FontAwesomeIcons.tag,
                      onPressed: () => onItemPressed(context, index: 0),
                    ),
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
                    BecomeDriver(
                      onClicked: () => onItemPressed(context, index: 5),
                    ),
                    WaitingforResponse(),
                    rejected(
                      onClicked: () => onItemPressed(context, index: 5),
                    ),
                    deleted(onClicked: () => onItemPressed(context, index: 5),),
                   // AlreadyHasAnAccount()
                  ],
                ),
              ),
            ));
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);

    switch (index) {
      case 0:
        Get.to(() => Promotion());
        ;
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
        Get.to(() => User());
        break;
      case 5:
        Get.to(() => RegisterConductorPage());
        break;
       case 6:
        Get.to(() => Support());
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
                    "images/userA.png",
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
                      Text(textEditing(Text: '${currentUser?.username}'),
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

  Widget BecomeDriver({
    required VoidCallback onClicked,
    // required bool Function() isdriving ()
    //  if (currentUser?.isdriver)
  }) =>
      Visibility(
        visible: isdriver,
        child: InkWell(
          hoverColor: Colors.transparent,
          onTap: onClicked,
          child: Column(
            children: [
              Container(
                height: 60.h,
                width: 200.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Become a transporteur  ",
                        style: TextStyle(
                            fontSize: 15,
                            color:  Color(0xFF005b71),
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        " earn money on your schedule ",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF005b71),
                          //color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color :Color.fromARGB(62, 255, 255, 255),
                 // color:  Color(0xFF005b71),
                  // gradient: LinearGradient(
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight,
                  //     colors: [
                  //       Color.fromARGB(62, 0, 90, 113),
                  //       Color.fromARGB(62, 255, 255, 255),
                  //     ]),
                  border: Border.all(
                     color: Colors.white,
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

Widget rejected({
  required VoidCallback onClicked,
}) =>
    Visibility(
      visible: Rejected,
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: onClicked,
        child: Column(
          children: [
            Container(
              height: 60.h,
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Your request has been rejected ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 113, 13, 0),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      " Tap here to re register ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 113, 13, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color :Color.fromARGB(62, 255, 255, 255),
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //       Color.fromARGB(60, 113, 15, 0),
                //       Color.fromARGB(62, 255, 255, 255),
                //     ]),
                border: Border.all(
                  color: Color.fromARGB(255, 113, 13, 0),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
Widget deleted({
required VoidCallback onClicked,
}
  
) => Visibility(
      visible: isDeleted,
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: onClicked,
        child: Column(
          children: [
            Container(
              height: 60.h,
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Your Transporter Account Has Been Deleted ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 113, 13, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      " You can no longer register ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 113, 13, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color :Color.fromARGB(62, 255, 255, 255),
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //       Color.fromARGB(60, 113, 15, 0),
                //       Color.fromARGB(62, 255, 255, 255),
                //     ]),
                border: Border.all(
                  color: Color.fromARGB(255, 113, 13, 0),
                  width: 1.5,
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.white.withOpacity(0.1),
                //     spreadRadius: 1,
                //     blurRadius: 5,
                //     offset: Offset(1, 3),
                //   ),
                // ],
              ),
            ),
          ],
        ),
      ),
    );

Widget WaitingforResponse() => Visibility(
      visible: pending,
      child: InkWell(
        hoverColor: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 60.h,
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Your request is being reviewed ",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFF7B30c),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                //color :Color.fromARGB(62, 255, 255, 255),
                // gradient: LinearGradient(
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     colors: [
                //       Color.fromARGB(63, 247, 181, 12),
                //       Color.fromARGB(62, 255, 255, 255),
                //     ]),
                border: Border.all(
                  color: Color(0xFFF7B30c),
                  width: 1.5,
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Color(0xFFF7B30c).withOpacity(0.1),
                //     spreadRadius: 1,
                //     blurRadius: 5,
                //     offset: Offset(1, 3),
                //   ),
                // ],
              ),
            ),
          ],
        ),
      ),
    );
// Widget AlreadyHasAnAccount() => Visibility(
//       visible: isconductor,
//       child: InkWell(
//         hoverColor: Colors.transparent,
//         child: Column(
//           children: [
//             Container(
//               height: 60.h,
//               width: 200.w,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Text(
//                       "You Already Has a Transporter \nAccount ",
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Color.fromARGB(255, 0, 113, 17),
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                // color :Color.fromARGB(62, 255, 255, 255),
//                 // gradient: LinearGradient(
//                 //     begin: Alignment.topLeft,
//                 //     end: Alignment.bottomRight,
                    
//                     // colors: [
//                     //   Color.fromARGB(61, 0, 113, 21),
//                     //   Color.fromARGB(62, 255, 255, 255),
//                     // ]),
//                 border: Border.all(
//                   color: Color.fromARGB(255, 0, 113, 9),
//                   width: 1.5,
//                 ),
//                 // boxShadow: [
//                 //   BoxShadow(
//                 //     color: Colors.white.withOpacity(0.1),
//                 //     spreadRadius: 1,
//                 //     blurRadius: 5,
//                 //     offset: Offset(1, 3),
//                 //   ),
//                 // ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
