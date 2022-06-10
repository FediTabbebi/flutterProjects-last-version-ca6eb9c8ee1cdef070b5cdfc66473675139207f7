// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widgets/button_widget.dart';
import '../../data/globals.dart';
import '../../services/userServices/Register_Login.dart';
import 'Login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  bool passwordObscured = true;
  late TextEditingController emailController,
      passwordController,
      confirmpasswordController,
      usernameController;

  var email;
  var password;
  var userName;
  var confirmpassword;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    confirmpasswordController = TextEditingController();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email";
    }
    return null;
  }

  String? validateUsername(String value) {
    if (value.isEmpty) return "Username can't be empty";
    if (value.length < 3) {
      return "Username must be at least 3";
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 4) return "password must be at least 4 characters ";
    if (!password.contains(RegExp(r"[a-z]")))
      return "password must contains letters";
    if (!password.contains(RegExp(r"[A-Z]")))
      return "password must contains an uppercase character";
    if (!password.contains(RegExp(r"[0-9]")))
      return "password must contains a digit number";
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
      return "password must contains special characters ";
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (password != confirmpassword) {
      return "Password does not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: loginFormKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Container(
                            child: Text("REGISTER",
                                style: GoogleFonts.roboto(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff007097))))),
                    SizedBox(height: 50),
                    TextFormField(
                      maxLength: 15,
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
                        // filled: true,
                        // fillColor: Color.fromARGB(255, 243, 243, 243),
                        labelText: "Full name",
                        labelStyle:
                            GoogleFonts.roboto(color: Color(0xff007097)),
                        prefixIcon:
                            Icon(Icons.person, color: Color(0xFF005b71)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        userName = value.trim();
                      },
                      controller: usernameController,
                      onSaved: (value) {
                        userName = value!.trim();
                      },
                      validator: (value) {
                        return validateUsername(value!);
                      },
                    ),
                    SizedBox(height: 5),
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
                        labelStyle:
                            GoogleFonts.roboto(color: Color(0xff007097)),
                        prefixIcon: Icon(Icons.email, color: Color(0xFF005b71)),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      controller: emailController,
                      onSaved: (value) {
                        email = value!;
                      },
                      validator: (value) {
                        return validateEmail(value!);
                      },
                    ),
                    SizedBox(height: 25),
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
                        labelStyle:
                            GoogleFonts.roboto(color: Color(0xff007097)),
                        prefixIcon:
                            Icon(Icons.vpn_key, color: Color(0xFF005b71)),
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
                      controller: passwordController,
                      onSaved: (value) {
                        password = value!;
                      },
                      validator: (value) {
                        return validatePassword(value!);
                      },
                    ),
                    SizedBox(height: 25),
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
                        labelText: "Confirm Password",
                        labelStyle:
                            GoogleFonts.roboto(color: Color(0xff007097)),
                        prefixIcon:
                            Icon(Icons.vpn_key, color: Color(0xFF005b71)),
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
                        confirmpassword = value;
                      },
                      obscureText: passwordObscured,
                      controller: confirmpasswordController,
                      onSaved: (value) {
                        confirmpassword = value!;
                      },
                      validator: (value) {
                        return validateConfirmPassword(value!);
                      },
                    ),
                    SizedBox(height: 50),
                    ButtonWidget(
                        text: "REGISTER",
                        onClicked: () async {
                          var x = checkLogin();
                          if (x) {
                            await APIServiceUser.Register(
                                userName, email, password);
                            if (checkRegister) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Your account has been created successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(255, 33, 125, 56),
                                  textColor: Colors.white,
                                  fontSize: 20.0);

                              Get.off(() => LoginPage(),
                                  transition: Transition.zoom);
                            } else if (x && !checkRegister) {
                              Get.defaultDialog(
                                  title: "Error",
                                  titleStyle: TextStyle(
                                      fontSize: 30,
                                      color: Color(0xFFE40613),
                                      fontWeight: FontWeight.bold),
                                  middleText: "Adress email already in use",
                                  middleTextStyle: TextStyle(
                                      color: Color(0xFF005b71), fontSize: 20));
                            }
                          }
                        }),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Already Member ?  ",
                            style: GoogleFonts.roboto(fontSize: 17.5),
                          ),
                          GestureDetector(
                            child: Text(
                              "Login Now",
                              style: GoogleFonts.roboto(
                                  color: Color(0xFF005b71), fontSize: 17.5),
                            ),
                            onTap: () {
                              Get.to(() => LoginPage(),
                                  transition: Transition.upToDown);
                              duration:
                              Duration(seconds: 2);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      loginFormKey.currentState!.save();
      return true;
    }
  }
}
