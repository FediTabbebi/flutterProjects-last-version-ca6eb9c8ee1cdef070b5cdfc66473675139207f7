import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iblaze/pages/CLient/Login_page.dart';

import '../../data/globals.dart';

import '../Conductor/conductorLoginAs.dart';
import 'HomePage.dart';
import 'SideBar/NaviagtionDrawer.dart';
import 'SideBar/UserAccpetedOffers.dart';
import 'offers.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class ClientPage extends StatefulWidget {
  int index;

  ClientPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState(index);
}

class _ClientPageState extends State<ClientPage> {
  _ClientPageState(this.index);
  int index = 0;
  DateTime timeBackPressed = DateTime.now();
  final screens = [HomePage(), Offers(), UserAcceptedOffers()];
 @override
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentUser?.Status == "active") {
          Get.to(() => LoginChoices());
        }
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();

        if (isExitWarning && currentUser?.Status == "none") {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(
            msg: message,
            fontSize: 15,
            backgroundColor: Color.fromARGB(255, 65, 64, 64),
          );

          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: SafeArea(
          child: Scaffold(
           
            body: screens[index],
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                height: 45.h,
                indicatorColor: Colors.transparent,
                labelTextStyle: MaterialStateProperty.all(TextStyle(
                    fontSize: 10.h.w,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
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
                      icon: Icon(Icons.home, color: Colors.white, size: 25),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.file_copy, color: Colors.white, size: 25),
                      label: 'Your offers',
                    ),
                    NavigationDestination(
                      icon: Icon(FontAwesomeIcons.solidPaperPlane,
                          color: Colors.white, size: 25),
                      label: 'Propositions',
                    ),
                  ]),
            ),
            drawer: NavigationDrawer(),
            appBar: AppBar(
                
                
              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Center(
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Color(0xFF005b71),fontWeight: FontWeight.bold),
                          ),
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
             // foregroundColor: Color(0xFF005b71),
             // shadowColor: Colors.transparent,
            ),
          ),
        
      ),
    );
  }
}
