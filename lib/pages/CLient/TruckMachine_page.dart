// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:iblaze/data/globals.dart';
// import 'package:iblaze/pages/Conductor/LoginAs.dart';
// import 'package:iblaze/services/userServices/Register_Login.dart';

// import '../../services/userServices/Offre_Api.dart';
// import 'ClientPage.dart';

// class TruckMachine extends StatefulWidget {
//   const TruckMachine({Key? key}) : super(key: key);

//   @override
//   State<TruckMachine> createState() => _TruckMachineState();
// }

// class _TruckMachineState extends State<TruckMachine> {
//   DateTime timeBackPressed = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
      
//     });

//     //print("variable is driver : " + "${isDr}");
//     // print("variable is driver : " + "${isDriver}");
//   }

//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       builder:
//           () => /*WillPopScope(
//         onWillPop: () async {
//           final difference = DateTime.now().difference(timeBackPressed);
//           final isExitWarning = difference >= Duration(seconds: 2);
//           timeBackPressed = DateTime.now();

//           if (isExitWarning) {
//             final message = 'Press back again to exit';
//             Fluttertoast.showToast(msg: message, fontSize: 18);
//             return false;
//           } else {
//             Fluttertoast.cancel();
//             return true;
//           }
//         },
//         child:*/
//               WillPopScope(
//         onWillPop: () async {
//           if (currentUser?.isdriver != null) {
//             Get.to(() => LoginAs());
//           }

//           return true;
//         },
//         child: SafeArea(
//           child: Scaffold(
//               resizeToAvoidBottomInset: false,
//               body: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => ClientPage(index:0)),
//                         );
//                       },
//                       child: Container(
//                           height: MediaQuery.of(context).size.height / 2,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF005b71),
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(75),
//                                 bottomRight: Radius.circular(75)),
//                           ),
//                           child: Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(
//                                     left: 30.w,
//                                     right: 30.w,
//                                     top: 30.h,
//                                     bottom: 30.h,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     /*borderRadius:
//                                   BorderRadius.only(bottomLeft: Radius.circular(100)),*/
//                                   ),
//                                   child: Image.asset(
//                                     "images/Van.png",
//                                     height: 160.h,
//                                     width: 160.w,
//                                   ),
//                                 ),
//                                 Text("Removal Van",
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold))
//                               ],
//                             ),
//                           )),
//                     ),
//                     Container(
//                         height: MediaQuery.of(context).size.height / 2,
//                         color: Colors.white,
//                         /* decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 colors: [
//                                   Color(0xFF005b71),
//                                   Color(0xFFFFFFFF),
//                                 ]),
//                             color: Colors.white,
//                             /* borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(100),
//                             ),*/
//                           ),*/
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(
//                                   left: 30.w,
//                                   right: 30.w,
//                                   top: 30.h,
//                                   bottom: 30.h,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Image.asset(
//                                   "images/bull.png",
//                                   height: 160.h,
//                                   width: 160.w,
//                                 ),
//                               ),
//                               Text("Construction Machine",
//                                   style: TextStyle(
//                                       fontSize: 25,
//                                       color: Color(0xFF005b71),
//                                       fontWeight: FontWeight.bold))
//                             ],
//                           ),
//                         )),
//                   ],
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
// }
