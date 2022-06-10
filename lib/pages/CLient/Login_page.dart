import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/Widgets/button_widget.dart';
import 'package:iblaze/pages/CLient/ClientPage.dart';
import 'package:iblaze/pages/CLient/Register_page.dart';
import '../../data/globals.dart';
import '../../services/conductorServices/Register_Login_Conductor.dart';
import '../../services/userServices/Register_Login.dart';
import '../Conductor/LoginAs.dart';
import 'TruckMachine_page.dart';
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordObscured = true;
  late TextEditingController emailController, passwordController;
  var password;
  var Email;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                    tag: "blaze",
                    child:
                        Image.asset("images/Lg.png", height: 140, width: 140)),
                SizedBox(height: 80),
                Center(
                    child: Center(
                        child: Container(
                            child: Text("SIGN IN",
                                style: GoogleFonts.roboto(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff007097)))))),
                SizedBox(height: 50),
                TextFormField(
                  cursorColor: Color(0xFF005b71),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF005b71)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Color(0xff007097)),
                    prefixIcon: Icon(Icons.email, color: Color(0xFF005b71)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    Email = value;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  cursorColor: Color(0xFF005b71),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF005b71)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Color(0xff007097)),
                    prefixIcon: Icon(Icons.vpn_key, color: Color(0xFF005b71)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordObscured = !passwordObscured;
                        });
                      },
                      icon: Icon(
                          passwordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xff007097)),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: passwordObscured,
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 10, right: 15),
                //   child: Container(
                //     alignment: Alignment.centerRight,
                //     child: GestureDetector(
                //       onTap: () {},
                //       child: Text("Forget Password?",
                //           style: TextStyle(
                //             color: Color(0xFF005b71),
                //           )),
                //     ),
                //   ),
                // ),
                SizedBox(height: 30),
                ButtonWidget(
                    text: "LOGIN",
                    onClicked: () async {
                      await APIServiceUser.login(Email, password);
                      print(Email);
                      print(password);
                      print(currentUser?.Status);
                      //print("isDriVVEr : " "${currentUser?.isdriver}");
                      if (checkLogin && currentUser?.Status == "active" ) {
                        APIServiceConductor.LoginConductor(Email, password);
                        Get.off(() => LoginAs());

                        userData.write("password", '${password}');
                        userData.write("email", '${Email}');
                      } 
                      if (checkLogin && !deletedUser &&
                          (currentUser?.Status == "pending" ||
                              currentUser?.Status == "deleted" ||
                              currentUser?.Status == "rejected" ||
                              currentUser?.Status == "none")) {
                        Get.off(() => ClientPage(index: 0));
                        userData.write("password", '${password}');
                        userData.write("email", '${Email}');
                        userData.write("userId", '${currentUser?.id}');
                        {}
                      }

                      if (checkLogin && deletedUser) {
                        // userData.remove("password");
                        // userData.remove("email");
                        Get.defaultDialog(
                            title: "Warning !",
                            titleStyle: TextStyle(
                                fontSize: 30,
                                color: Color(0xFFE40613),
                                fontWeight: FontWeight.bold),
                            middleText: " Your account has been deleted !",
                            middleTextStyle: TextStyle(
                                color: Color(0xFF005b71), fontSize: 20));
                      } if (!checkLogin){
                        Get.defaultDialog(
                            title: "Error",
                            titleStyle: TextStyle(
                                fontSize: 30,
                                color: Color(0xFFE40613),
                                fontWeight: FontWeight.bold),
                            middleText: "Invalid Email/Password !",
                            middleTextStyle: TextStyle(
                                color: Color(0xFF005b71), fontSize: 20));
                      }
                    }),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have Any Account ?  ",
                        style: TextStyle(fontSize: 17.5),
                      ),
                      GestureDetector(
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Color(0xFF005b71), fontSize: 17.5),
                        ),
                        onTap: () {
                          Get.to(() => RegisterPage(),
                              transition: Transition.downToUp);
                          duration:
                          Duration(seconds: 2);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
