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
            
              //resizeToAvoidBottomInset: false,
              body: Container(
                 height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        
                      //  Colors.white,
                        Color.fromARGB(100, 0, 90, 113),
                        Color.fromARGB(62, 255, 255, 255),
                        
                      ]),
              ),
                  // color: Color.fromARGB(60, 0, 89, 111),
                  child: Center(
                    child: Column(
                    
               children: [
              
                
                    Container(
               
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
               child: ChoiceChip(
               shape: CircleBorder(side: BorderSide(color: userColor, width: 2),
               ),
               backgroundColor: Colors.white,
              selectedColor:  Color(0xFF005b71),
              selectedShadowColor:userColor,
              
              elevation: 15,
               
               selected: SelectedUser,
               disabledColor:Color(0xFF005b71), 
               onSelected: (newBoolValue)
               {
   
                 setState(() {
                   userColor=Colors.white;
                  conductorColor=Color(0xFF005b71);
                   SelectedUser= newBoolValue;
                   SelectedConductor=false;
                                print ("Selected conductor : "+"${SelectedConductor}");
                print ("Selected user : "+"${SelectedUser}");
                 });
                 if (!newBoolValue){
                  userColor=Color(0xFF005b71);
                 // SelectedUser=true;
                 }
               },
              
               label: Container(
                width: 120.h.w,
                  height: 140.h.w,
                 decoration: BoxDecoration(
                    gradient: LinearGradient(
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               
               colors: [
                 Color.fromARGB(62, 0, 90, 113),
                 Color.fromARGB(62, 255, 255, 255),
               ]),
               shape: BoxShape.circle,
                  ),child:Column(
                 children: 
                   [
                 
                 Image.asset(
                                         "images/userA.png",),
                    
                  
                   
                   Text("USER",style: GoogleFonts.roboto(color: userColor,fontWeight: FontWeight.bold))
                 ],
               ),
                    
              
                 ),
                    ),
                    ),
               
                   Container(
                    height: MediaQuery.of(context).size.height / 4,
              child: ChoiceChip(
               shape: CircleBorder(side: BorderSide(color: conductorColor, width: 2)),
               backgroundColor: Colors.white,
               selectedColor:  Color(0xFF005b71),
               selected: SelectedConductor,
               elevation: 15,
               selectedShadowColor:conductorColor,
               onSelected: (newBoolValue)
               {
               
                 setState(() {
                   conductorColor=Colors.white;
                   userColor=Color(0xFF005b71);
                   SelectedConductor= newBoolValue;
                   SelectedUser=false;
                    print ("Selected conductor : "+"${SelectedConductor}");
                print ("Selected user : "+"${SelectedUser}");
                 });
                  if (!newBoolValue){
                  conductorColor=Color(0xFF005b71);
                  SelectedConductor=false;
                 }
               },
              
               label: Container(
                width: 120.h.w,
                  height: 140.h.w,
                 decoration: BoxDecoration(
                    gradient: LinearGradient(
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
               
               colors: [
                 Color.fromARGB(62, 0, 90, 113),
                 Color.fromARGB(62, 255, 255, 255),
               ]),
               shape: BoxShape.circle,
                  ),child:Column(
                 children: 
                   [
                 
                 Image.asset("images/conductor.png",),
                    
                  
                   
                   Text("Transporter",style: GoogleFonts.roboto(color: conductorColor,fontWeight: FontWeight.bold))
                 ],
               ),
                    
              
                 ),
                    ),
                    ),
              
                        
                           
                 Container(
                 height: MediaQuery.of(context).size.height / 6,
                 width: double.infinity,
                
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                 children: 
               [Container(
                 
                 padding: EdgeInsets.only( left:30,right:30),
                 height: 50.h,
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
                if (SelectedConductor==false && SelectedUser==false) {
                  Fluttertoast.showToast(
                                  msg:
                                      "Please select a role",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(132, 0, 0, 0),
                                  textColor: Colors.white,
                                  fontSize: 17.5);
                }
                   },
                   child: Text("Continue",
                
                style: GoogleFonts.roboto(color: Colors.white, fontSize: 17.5,fontWeight: FontWeight.bold),
                   ),
                    style: TextButton.styleFrom(
                         primary: Color.fromARGB(255, 0, 90, 113),
                       backgroundColor: Color(0xFF005b71),
                         shape: new RoundedRectangleBorder(
                           side: BorderSide(
                              color: Colors.white,
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
              )
              ),
        ),
      ),
    );
  }
  
}
