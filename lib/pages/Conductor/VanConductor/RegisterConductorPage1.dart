import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/CLient/HomePage.dart';
import '../../../services/conductorServices/Register_Login_Conductor.dart';
import '../../../services/conductorServices/truckAPI.dart';
import '../../../services/userServices/Register_Login.dart';
import '../../../services/userServices/Uplaod_images.dart';
import '../../CLient/ClientPage.dart';
import '../../CLient/Login_page.dart';
import 'package:image_picker/image_picker.dart';

class RegisterConductorPage extends StatefulWidget {
  const RegisterConductorPage({Key? key}) : super(key: key);

  @override
  State<RegisterConductorPage> createState() => _RegisterConductorPageState();
}

class _RegisterConductorPageState extends State<RegisterConductorPage> {
  String TruckLicense = "";
  String TruckModel = "";
  File? TruckLicenseImage;
  File? TruckPhotoImage;
  File? DriverLicenseImage;
  File? DriverCINImage;
  var TruckLicenseImageID;
  var TruckPhotoImageID;
  var DriverLicenseImageID;
  var DriverCINImageID;

  bool VerifypickImage = true;
  int currentStep = 0;

  Future getImage() async {
    var Picture;
    final pickedFile = await await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      Picture = File(pickedFile.path);

      setState(() {});
    } else {
      print('no image selected');
      VerifypickImage = false;
    }
    return Picture;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Color(0xFF005b71))),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () async {
            final beforeLastStep = currentStep == getSteps().length - 2;
            if (beforeLastStep) {
              if (TruckLicenseImage == null ||
                  DriverCINImage == null ||
                  DriverLicenseImage == null ||
                  TruckPhotoImage == null) {
                Get.defaultDialog(
                    title: "Error",
                    titleStyle: TextStyle(
                        fontSize: 25,
                        color: Color(0xFFE40613),
                        fontWeight: FontWeight.bold),
                    middleText: "Check your inscription's details ! ",
                    middleTextStyle:
                        TextStyle(color: Color(0xFF005b71), fontSize: 17.5,fontWeight: FontWeight.bold));
              } else {
                TruckLicenseImageID =
                    await UploadImages.uploadTruckDriverPictures(
                        TruckLicenseImage!,
                        "${currentUser?.email}" +
                            "${TruckLicense}" +
                            "truckpaper.png");

                TruckPhotoImageID =
                    await UploadImages.uploadTruckDriverPictures(
                        TruckPhotoImage!,
                        "${currentUser?.email}" +
                            "${TruckLicense}" +
                            "truckimage.png");

                DriverLicenseImageID =
                    await UploadImages.uploadTruckDriverPictures(
                        DriverLicenseImage!,
                        "${currentUser?.email}" + "drivinglicense.png");

                DriverCINImageID = await UploadImages.uploadTruckDriverPictures(
                    DriverCINImage!, "${currentUser?.email}" + "cin.png");
                if (!checkUpload) {
                  Get.defaultDialog(
                      title: "Error",
                      titleStyle: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFE40613),
                          fontWeight: FontWeight.bold),
                      middleText:
                          "Some images can't be uploaded\n please try again ",
                      middleTextStyle:
                          TextStyle(color: Color(0xFF005b71), fontSize: 20));
                } else {
                  await APIServiceConductor.RegisterConductor(
                      currentUser?.username,
                      currentUser?.email,
                      userData.read("password"),
                      TruckModel,
                      TruckLicense,
                      TruckLicenseImageID,
                      TruckPhotoImageID,
                      DriverLicenseImageID,
                      DriverCINImageID);

                  print(currentUser?.username);
                  print(currentUser?.email);
                  print(userData.read("password"));
                  print(TruckModel);
                  print(TruckLicense);
                  if (checkRegisterCondcuctor) {
                    setState(() {
                      currentStep += 1;
                    });

                    Fluttertoast.showToast(
                        msg: "your request has been sent successfully",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromARGB(255, 33, 125, 56),
                        textColor: Colors.white,
                        fontSize: 20.0);

                    pending = true;
                    isdriver = false;
                    isconductor = false;
                    Rejected = false;
                    isDeleted = false;

                    // Get.off(() => LoginPage()
                    // );
                  } else {
                    Get.defaultDialog(
                      title: "Error",
                                titleStyle: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFFE40613),
                                    fontWeight: FontWeight.bold),
                        middleText: "Check your inscription's details !",
                        middleTextStyle:
                            TextStyle( fontSize: 17.5,fontWeight: FontWeight.bold));
                  }
                }
              }

              //API
            } else {
              setState(() {
                currentStep += 1;
              });
            }
            ;
          },
          onStepCancel: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              Get.to(() => ClientPage(index: 0));
            }
            currentStep == 0
                ? null
                : setState(() {
                    currentStep -= 1;
                  });
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;
            final beforeLastStep = currentStep == getSteps().length - 2;
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //SizedBox(width: 20),
                    if (currentStep != getSteps().length - 1)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            beforeLastStep ? 'CONFIRM' : 'NEXT',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.5),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF005b71),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                      ),
                    if (currentStep != 0 &&
                        currentStep != getSteps().length - 1)
                      SizedBox(width: 20),
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepCancel,
                          child: Text(
                            isLastStep ? 'BACK TO MAIN PAGE' : 'BACK',
                            style: TextStyle(
                                color: Color(0xFF005b71), fontSize: 17.5),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 209, 208, 208),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF005b71)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
          // onStepTapped: (step) {
          //   if (currentStep != getSteps().length - 1) {
          //     setState(() => currentStep = step);
          //   }
          // }
        ),
      )),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            content: Container(
                child: Column(
              children: [
                TextFormField(
                  cursorColor: Color(0xFF005b71),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 1.5, color: Color(0xFF005b71)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 1.5, color: Color(0xFF005b71)),
                    ),
                    labelText: "Truck Model",
                    labelStyle: GoogleFonts.roboto(color: Color(0xff007097)),
                    prefixIcon: Icon(
                      FontAwesomeIcons.truck,
                      color: Color(0xFF005b71),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    TruckModel = value;
                    ;
                  },
                ),
                SizedBox(height: 15),
                TextField(
                  cursorColor: Color(0xFF005b71),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 1.5, color: Color(0xFF005b71)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 1.5, color: Color(0xFF005b71)),
                    ),

                    // filled: true,
                    // fillColor: Color.fromARGB(255, 243, 243, 243),
                    labelText: "Truck License Plate",
                    labelStyle: GoogleFonts.roboto(color: Color(0xff007097)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    TruckLicense = value;
                    ;
                  },
                ),
              ],
            )),
            title: Text("Truck's info")),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            content: Container(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Center(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color(0xFF005b71),
                                width: 1.5,
                              )),
                          child: Column(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Truck's License",
                                        style: GoogleFonts.roboto(
                                            fontSize: 22, color: Colors.grey)),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("Required *",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Color(0xFFE40613))),
                                  ),
                                ]),
                            SizedBox(height: 27),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      height: 50,
                                      child: TruckLicenseImage != null
                                          ? Image.file(
                                              TruckLicenseImage!,
                                              width: 80,
                                              height: 80,
                                            )
                                          : Image.asset('images/Lg.png',
                                              height: 80, width: 80)),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 39,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        TruckLicenseImage =
                                            await getImage() as File?;
                                      },
                                      label: Text(
                                        "Upload Image",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 17.5),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xFF005b71),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                      icon: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]))),
                  SizedBox(height: 20),
                  Center(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color(0xFF005b71),
                                width: 1.5,
                              )),
                          child: Column(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Truck's Photo",
                                        style: GoogleFonts.roboto(
                                            fontSize: 22, color: Colors.grey)),
                                  ),
                                 
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("Required *",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Color(0xFFE40613))),
                                  ),
                                ]),
                            SizedBox(height: 27),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      height: 50,
                                      child: TruckPhotoImage != null
                                          ? Image.file(
                                              TruckPhotoImage!,
                                              width: 80,
                                              height: 80,
                                            )
                                          : Image.asset('images/Lg.png',
                                              height: 80, width: 80)),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 39,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        TruckPhotoImage =
                                            await getImage() as File?;
                                      },
                                      label: Text(
                                        "Upload Image",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 17.5),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xFF005b71),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                      icon: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]))),
                ])),
            title: Text("Documents")),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            content: Container(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Center(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color(0xFF005b71),
                                width: 1.5,
                              )),
                          child: Column(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Driver's License",
                                        style: GoogleFonts.roboto(
                                            fontSize: 22, color: Colors.grey)),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("Required *",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Color(0xFFE40613))),
                                  ),
                                ]),
                            SizedBox(height: 27),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      height: 50,
                                      child: DriverLicenseImage != null
                                          ? Image.file(
                                              DriverLicenseImage!,
                                              width: 80,
                                              height: 80,
                                            )
                                          : Image.asset('images/Lg.png',
                                              height: 80, width: 80)),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 39,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        DriverLicenseImage =
                                            await getImage() as File?;
                                      },
                                      label: Text(
                                        "Upload Image",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 17.5),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xFF005b71),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                      icon: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]))),
                  SizedBox(height: 20),
                  Center(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Color(0xFF005b71),
                                width: 1.5,
                              )),
                          child: Column(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("National ID",
                                        style: GoogleFonts.roboto(
                                            fontSize: 22, color: Colors.grey)),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text("Required *",
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Color(0xFFE40613))),
                                  ),
                                ]),
                            SizedBox(height: 27),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      height: 50,
                                      child: DriverCINImage != null
                                          ? Image.file(
                                              DriverCINImage!,
                                              width: 80,
                                              height: 80,
                                            )
                                          : Image.asset('images/Lg.png',
                                              height: 80, width: 80)),
                                ),
                               // SizedBox(width: 70),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 39,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        DriverCINImage =
                                            await getImage() as File?;
                                      },
                                      label: Text(
                                        "Upload Image",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 17.5),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color(0xFF005b71),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                      icon: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]))),
                ])),
            title: Text("Legal Details")),
        Step(
            isActive: currentStep >= 3,
            content: Center(
              child: Container(
                  height: 140,
                  padding: EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color.fromARGB(255, 33, 125, 56),
                          width: 10,
                        ),
                      ),
                      color: Color.fromARGB(255, 210, 210, 210)
                      // width: 1.5,
                      ),
                  child: Column(children: [
                    Row(
                      
                      children: [
                        Container(
                            child: Icon(
                          Icons.verified,
                          color: Color.fromARGB(255, 33, 125, 56),
                        )),
                        SizedBox(width: 50),
                        Text("Your request is being reviewed",
                            style: TextStyle(
                                fontSize: 17.5, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      
                    
                      children: [
                        SizedBox(width: 75),
                        Text(
                            "Your account will be upgraded to driver\nwhen your request has been processed."),
                      ],
                    )
                  ])),
            ),
            title: Text("")),
      ];
}

         
          //  SizedBox(height: 30),
          //           ButtonWidget(
          //               text: "Register",
          //               onClicked: () async {
          //                 print(TruckModel);
          //                 print(TruckLicense);
          //                 print(currentUser?.username);
          //                 print(currentUser?.email);
          //                 print(userData.read("password"));
          //                 print(currentTruck?.TruckId);

          //                 await APITruckServices.RegisterTruck(
          //                     TruckModel, TruckLicense);

          //                 if (truckRegisterCheck) {
          //                   await APIServiceConductor.RegisterConductor(
          //                       currentUser?.username,
          //                       currentUser?.email,
          //                       userData.read("password"),
          //                       currentTruck?.TruckId);
          //                   if (checkRegisterCondcuctor) {
          //                     APIServiceUser.UpdateStatus(
          //                         currentUser?.username);

          //                     Fluttertoast.showToast(
          //                         msg: "you have been registered successfully",
          //                         toastLength: Toast.LENGTH_SHORT,
          //                         gravity: ToastGravity.BOTTOM,
          //                         timeInSecForIosWeb: 1,
          //                         backgroundColor:
          //                             Color.fromARGB(255, 33, 125, 56),
          //                         textColor: Colors.white,
          //                         fontSize: 20.0);
          //                     Get.off(() => LoginPage());
          //                   } else {
          //                     await APITruckServices.DeleteTruck(
          //                         currentTruck?.TruckId,
          //                         currentConductor?.conductorId);
          //                     Get.defaultDialog(
          //                         title: "Error",
          //                         titleStyle: TextStyle(
          //                             fontSize: 30,
          //                             color: Color(0xFFE40613),
          //                             fontWeight: FontWeight.bold),
          //                         middleText: "You can not be registred ",
          //                         middleTextStyle: TextStyle(
          //                             color: Color(0xFF005b71), fontSize: 20));
          //                   }
          //                 } else {
          //                   Get.defaultDialog(
          //                       title: "Error",
          //                       titleStyle: TextStyle(
          //                           fontSize: 30,
          //                           color: Color(0xFFE40613),
          //                           fontWeight: FontWeight.bold),
          //                       middleText: "Truck can not be registred ",
          //                       middleTextStyle: TextStyle(
          //                           color: Color(0xFF005b71), fontSize: 20));
          //                 }
          //               }),
