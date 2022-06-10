import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iblaze/pages/CLient/Login_page.dart';

import '../../data/globals.dart';

import 'HomePage.dart';
import 'SideBar/NaviagtionDrawer.dart';
import 'SideBar/UserAccpetedOffers.dart';
import 'offers.dart';

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
  final screens = [HomePage(), Offers(), UserAcceptedOffers()];
  @override
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
                  fontSize: 13,
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
                    icon: Icon(Icons.email, color: Colors.white, size: 25),
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
