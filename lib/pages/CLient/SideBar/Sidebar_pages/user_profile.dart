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
                    var x = checkupdate();
                    if (x) {
                      await APIServiceUser.Update(currentUser?.id, NewName);
                      if (checkUpdate) {
                        Get.back();
                    setState(() {
                      LastuserName=NewName;
                    });
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
                                fontSize: 25,
                                color: Color(0xFFE40613),
                                fontWeight: FontWeight.bold),
                            middleText: "Username can't be updated",
                            middleTextStyle: TextStyle(
                                color: Color(0xFF005b71), fontSize: 17.5, fontWeight: FontWeight.bold));
                      }
                      ;
                    }
                  })
            ],
          );
        });
  }

  bool checkupdate() {
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
    return SafeArea(
      child: Scaffold(
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
            //resizeToAvoidBottomInset: false,
            body: Stack(
              //crossAxisAlignment: CrossAxisAlignment.center,
              alignment: AlignmentDirectional.topCenter ,
              children: [
                
                Padding(
                  padding: const EdgeInsets.only(top:80),
                  child: Column(
                    children: 
                      [Container(
                          //  decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(100),
                          //             border: Border.all(
                          //               color: Color(0xFFF7B30c),
                          //               width: 2,
                          //             )),
                        child: Image.asset(
                          "images/userA.png",
                          height: 150,
                          width: 150,
                        ),
                      ),
                  //     child: Padding(
                  //  padding: EdgeInsets.only(left: 30, right: 30, bottom: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30,top: 30),
                          child: Text("${currentUser?.username}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 40,
                                   color: Color(0xFF005b71),
                                  fontWeight: FontWeight.bold,letterSpacing: 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,top:30),
                          child: GestureDetector(
                              onTap: () async {
                                await ShowInformationDialog(context);
                              },
                              child: Icon(Icons.edit,
                                  color: Colors.grey, size: 25)),
                        )
                      ],
                    ),
                     Text("${currentUser?.email}",
                        //textAlign: TextAlign.,
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF005b71),letterSpacing: 3.0)),
                  
                    ],
                  ),
                ),
               
              //  SizedBox(height: 220),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 15,bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Row(
                      //  crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Account Created On : ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                   color: Color(0xFF005b71),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          Text("${currentUser?.creationDate}",
                              textAlign: TextAlign.center,
                              style: TextStyle(color:Color(0xFFF7B30c), fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
