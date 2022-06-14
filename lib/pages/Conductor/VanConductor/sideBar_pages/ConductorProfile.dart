import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                        "images/conductor.png",
                        height: 150,
                        width: 150,
                      ),
                    ),
                //     child: Padding(
                //  padding: EdgeInsets.only(left: 30, right: 30, bottom: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${currentConductor?.conductorName}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 40,
                               color: Color(0xFF005b71),
                              fontWeight: FontWeight.bold,letterSpacing: 1)),
                     
                    ],
                  ),
                   Text("${currentConductor?.conductorEmail}",
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
                        Text("${currentConductor?.creationDate}",
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
    );
  }
}
