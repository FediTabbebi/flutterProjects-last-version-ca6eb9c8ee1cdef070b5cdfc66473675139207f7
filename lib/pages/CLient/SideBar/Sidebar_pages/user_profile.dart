import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/services/userServices/Register_Login.dart';

import '../../../../Models/conductor.dart';
import '../../../../services/conductorServices/Register_Login_Conductor.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  bool isvisible = false;
  //var userName;
  var LastuserName;
  String? NewName;
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  String? validateUsername(String value) {
    if (value.isEmpty) return "Username can't be empty";
    if (value.length < 3) {
      return "Username must be at least 3";
    }

    return null;
  }

  Future<void> ShowInformationDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: Container(
              // height: 300,
              width: 300,
              child: Form(
                key: loginFormKey,
                child: TextFormField(
                  maxLength: 15,
                  cursorColor: Color(0xFF005b71),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Color(0xFF005b71),
                    ),
                    hintText: "Write your new username",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF005b71),
                      ),
                    ),
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: (value) {
                    NewName = value.trim();
                  },
                  controller: usernameController,
                  onSaved: (value) {
                    NewName = value!.trim();
                  },
                  validator: (value) {
                    return validateUsername(value!);
                  },
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text("Update",
                      style: TextStyle(color: Color(0xFF005b71))),
                  onPressed: () async {
                    var x = checkLogin();
                    if (x) {
                      await APIServiceUser.Update(currentUser?.id, NewName);
                      if (checkUpdate) {
                        Get.back();
                   
                        currentConductor = new Conductor(
                          NewName,
                          currentConductor?.conductorEmail,
                         
                          currentConductor?.Truck,
                          currentConductor?.creationDate,
                          currentConductor?.conductorId,
                          currentConductor?.Status
                        );
                       // currentConductor?.conductorName = NewName;
                        userData.write("username", '${NewName}');
                      } else if (!checkUpdate) {
                        Get.defaultDialog(
                            title: "Error",
                            titleStyle: TextStyle(
                                fontSize: 30,
                                color: Color(0xFFE40613),
                                fontWeight: FontWeight.bold),
                            middleText: "Username can't be updated",
                            middleTextStyle: TextStyle(
                                color: Color(0xFF005b71), fontSize: 20));
                      }
                      ;
                    }
                  })
            ],
          );
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFF005b71),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(62, 255, 255, 255),
                      Color.fromARGB(62, 0, 90, 113),
                    ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 80),
                  Image.asset(
                    "images/userA.png",
                    height: 120,
                    width: 120,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text("${currentUser?.username}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                              onTap: () async {
                                await ShowInformationDialog(context);
                              },
                              child: Icon(Icons.edit,
                                  color: Colors.grey, size: 20)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 5),
                    child: Text("${currentUser?.email}",
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF005b71))),
                  ),
                  SizedBox(height: 220),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Account Created On : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 124, 124),
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Text("${currentUser?.creationDate}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
