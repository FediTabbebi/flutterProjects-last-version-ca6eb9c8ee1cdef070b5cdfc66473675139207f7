import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iblaze/data/globals.dart';
// import 'changeName.dart';

class ConductorProfile extends StatefulWidget {
  const ConductorProfile({Key? key}) : super(key: key);

  @override
  State<ConductorProfile> createState() => _ConductorProfileState();
}

class _ConductorProfileState extends State<ConductorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Color(0xFF005b71),
      ),
      body: Scaffold(
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
                  "images/conductor.png",
                  height: 140,
                  width: 140,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${currentConductor?.conductorName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 5),
                  child: Text("${currentConductor?.conductorEmail}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Color(0xFF005b71))),
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
                      Text("${currentConductor?.creationDate}",
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
    );
  }
}
