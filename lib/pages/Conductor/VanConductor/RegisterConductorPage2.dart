// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iblaze/data/globals.dart';
// import 'package:iblaze/services/conductorServices/Register_Login_Conductor.dart';
// import 'package:iblaze/services/userServices/Register_Login.dart';
// import '../../../Widgets/button_widget.dart';
// import '../../CLient/Login_page.dart';

// class RegisterConductorSecondPage extends StatefulWidget {
//   String LicensePlate;
//   String TruckModel;
//   RegisterConductorSecondPage(
//       {required this.LicensePlate, required this.TruckModel});
//   //const ({Key? key}) : super(key: key);

//   @override
//   _RegisterConductorSecondPageState createState() =>
//       _RegisterConductorSecondPageState(LicensePlate, TruckModel);
// }

// class _RegisterConductorSecondPageState
//     extends State<RegisterConductorSecondPage> {
//   String LicensePlate;
//   String TruckModel;
//   _RegisterConductorSecondPageState(this.LicensePlate, this.TruckModel);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(25.0),
//             child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Documents",
//                       style: GoogleFonts.roboto(
//                           fontSize: 40,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff007097))),
//                   SizedBox(height: 50),
//                   Container(
//                       padding: EdgeInsets.all(25.0),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(
//                             color: Color(0xFF005b71),
//                             width: 1.5,
//                           )),
//                       child: Column(children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Driver's lisence",
//                               style: GoogleFonts.roboto(
//                                   fontSize: 30, color: Colors.grey)),
//                         ),
//                         SizedBox(height: 50),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: Container(
//                             height: 43,
//                             child: ElevatedButton.icon(
//                               onPressed: () {},
//                               label: Text(
//                                 "Upload Image",
//                                 style: GoogleFonts.roboto(
//                                     color: Colors.white, fontSize: 17.5),
//                               ),
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                   Color(0xFF005b71),
//                                 ),
//                                 foregroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         Colors.white),
//                                 shape: MaterialStateProperty.all(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               icon: Icon(
//                                 Icons.add,
//                               ),
//                             ),
//                           ),
//                         )
//                       ])),
//                   SizedBox(height: 20),
//                   Container(
//                       padding: EdgeInsets.all(25.0),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(
//                             color: Color(0xFF005b71),
//                             width: 1.5,
//                           )),
//                       child: Column(children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Text("Truck's photo",
//                               style: GoogleFonts.roboto(
//                                   fontSize: 30, color: Colors.grey)),
//                         ),
//                         SizedBox(height: 50),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: Container(
//                             height: 43,
//                             child: ElevatedButton.icon(
//                               onPressed: () {},
//                               label: Text(
//                                 "Upload Image",
//                                 style: GoogleFonts.roboto(
//                                     color: Colors.white, fontSize: 17.5),
//                               ),
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                   Color(0xFF005b71),
//                                 ),
//                                 foregroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         Colors.white),
//                                 shape: MaterialStateProperty.all(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0))),
//                               ),
//                               icon: Icon(
//                                 Icons.add,
//                               ),
//                             ),
//                           ),
//                         )
//                       ])),
//                   SizedBox(height: 50),
//                   ButtonWidget(
//                       text: "Register",
//                       onClicked: () async {
//                         print(currentUser?.username);
//                         print("${currentUser?.email}" + " this is email");
//                         print(userData.read("password"));
//                         print(this.TruckModel);
//                         print(this.LicensePlate);

//                         await APIServiceConductor.RegisterConductor(
//                             currentUser?.username,
//                             currentUser?.email,
//                             userData.read("password"),
//                             TruckModel,
//                             LicensePlate);
//                         // await APIServiceConductor.RegisterConductor("fedi",
//                         //     "fedi", "fedi", "TruckModel", "LicensePlate");

//                         if (checkRegisterCondcuctor) {
//                           APIServiceUser.UpdateStatus(currentUser?.username);
//                           print("isDrive : " "${currentUser?.isdriver}");

//                           Get.off(() => LoginPage(),
//                               transition: Transition.zoom);
//                         } else {
//                           Get.defaultDialog(
//                               title: "Error",
//                               titleStyle: TextStyle(fontSize: 30),
//                               middleText: "Something went wrong ",
//                               middleTextStyle: TextStyle(
//                                   color: Color(0xFF005b71), fontSize: 20));
//                         }
//                       }),
//                 ]),
//           ),
//         ),
//       ),
//     ));
//   }
// }
