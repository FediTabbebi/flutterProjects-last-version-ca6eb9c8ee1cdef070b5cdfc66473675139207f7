import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/CLient/TruckMachine_page.dart';
import 'package:iblaze/pages/Conductor/VanConductor/conductorPage.dart';

import '../../Models/conductorOffers.dart';
import '../../services/conductorServices/conductorOffreAPI.dart';
import '../../services/userServices/Register_Login.dart';
import '../CLient/ClientPage.dart';
import 'VanConductor/RegisterConductorPage1.dart';

class LoginChoices extends StatefulWidget {
  const LoginChoices({Key? key}) : super(key: key);

  @override
  State<LoginChoices> createState() => _testingChipState();
}

class _testingChipState extends State<LoginChoices> {
 
  DateTime timeBackPressed = DateTime.now();
 bool SelectedUser=false;
  bool SelectedConductor=false;
  Color userColor=Color(0xFF005b71);
  Color conductorColor=Color(0xFF005b71);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context,child) => DoubleBack(
        message: "Press Back again to Exit The App",
        textStyle: TextStyle(fontSize: 15, color: Colors.white),
        //background: Colors.red,
        backgroundRadius: 10,
        child: SafeArea(
          child: Scaffold(
            
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Container(
               
            color: Color.fromARGB(62, 0, 90, 113),
            
                  child: Center(
                    child: Column(
                    
                      children: [

  
      Container(
        
         height: MediaQuery.of(context).size.height / 3,
         width: double.infinity,
        child: ChoiceChip(
        shape: CircleBorder(side: BorderSide(color: userColor, width: 2),
        ),
        backgroundColor: Colors.white,
       selectedColor: Colors.white,
       selectedShadowColor:userColor,
       elevation: 15,
        
        selected: SelectedUser,
        onSelected: (newBoolValue)
        {
          setState(() {
            userColor=Color(0xFFF7B30c);
            conductorColor=Color(0xFF005b71);
            SelectedUser= newBoolValue;
            SelectedConductor=false;
          });
        },

        label: Container(
           decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(62, 0, 90, 113),
                    Color.fromARGB(62, 255, 255, 255),
                  ]),
                  shape: BoxShape.circle,
            ),
            width: 120.h.w,
            height: 120.h.w,
            child: Image.asset(
                                            "images/userA.png",),
            
        ),
      

   ),
      ),
      Container(
        child:Text("USER",style: GoogleFonts.roboto(color: Color(0xFF005b71), fontSize: 25,fontWeight: FontWeight.bold))
      ),
 
     Container(
      height: MediaQuery.of(context).size.height / 3,
       child: ChoiceChip(
        shape: CircleBorder(side: BorderSide(color: conductorColor, width: 2)),
        backgroundColor: Colors.white,
        selectedColor: Colors.white,
        selected: SelectedConductor,
        elevation: 15,
        selectedShadowColor:conductorColor,
        onSelected: (newBoolValue)
        {
          setState(() {
            conductorColor=Color(0xFFF7B30c);
            userColor=Color(0xFF005b71);
            SelectedConductor= newBoolValue;
            SelectedUser=false;
          });
        },

        label: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(62, 0, 90, 113),
                    Color.fromARGB(62, 255, 255, 255),
                  ]),
                  shape: BoxShape.circle,
            ),
            width: 120.h.w,
            height: 120.h.w,
            child: Image.asset(
                                            "images/conductor.png",),
            
        ),

  ),
  
     ),
      Container(
        child:Text("CONDUCTOR",style: GoogleFonts.roboto(color: Color(0xFF005b71), fontSize: 25,fontWeight: FontWeight.bold))
      ),
                               
                                  
          Container(
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
         
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: 
        [Container(
          padding: EdgeInsets.only( left:30,right:30),
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
            onPressed:  () {
              if (SelectedConductor) {
               Get.to(() => VanConductor(index: 0));

                                    transition:
                                    Transition.fade;
                                     duration:
                              Duration(seconds: 2);
                                    
              }
              if (SelectedUser){
                Get.to(() => ClientPage(index: 0));
                                    transition:
                                     Transition.fade;
                                           duration:
                              Duration(seconds: 2);
              }
            },
            child: Text("Continue",
              
              style: GoogleFonts.roboto(color: Color(0xFF005b71), fontSize: 17.5,fontWeight: FontWeight.bold),
            ),
             style: TextButton.styleFrom(
                                primary: Color.fromARGB(255, 0, 90, 113),
                              backgroundColor: Colors.white,
                                shape: new RoundedRectangleBorder(
                                  side: BorderSide(
                                     color: Color(0xFF005b71),
                                           width: 2,
                                     style: BorderStyle.solid
                                       ), borderRadius: BorderRadius.circular(30)
                            
                                  
                                ),
             )
          ),
        ),
      ],
             )
          )
                       ],
                    ),
                  ),
      //          
       ),
              )
              ),
        ),
      ),
    );
  }
  
}
