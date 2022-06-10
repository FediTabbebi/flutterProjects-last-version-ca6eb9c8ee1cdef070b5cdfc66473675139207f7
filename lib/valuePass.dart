// //  if (TruckLicenseImageID == null ||
//                   DriverCINImageID == null ||
//                   DriverLicenseImageID == null ||
//                   TruckPhotoImageID == null) {
//                 Get.defaultDialog(
//                     title: "Error",
//                     titleStyle: TextStyle(
//                         fontSize: 30,
//                         color: Color(0xFFE40613),
//                         fontWeight: FontWeight.bold),
//                     middleText: "Check your inscription details ",
//                     middleTextStyle:
//                         TextStyle(color: Color(0xFF005b71), fontSize: 20));
//               } else {
//                 TruckLicenseImageID =
//                     await UploadImages.uploadTruckDriverPictures(
//                         TruckLicenseImage!,
//                         "${currentUser?.email}" +
//                             "${TruckLicense}" +
//                             "truckpaper.png");

//                 TruckPhotoImageID =
//                     await UploadImages.uploadTruckDriverPictures(
//                         TruckPhotoImage!,
//                         "${currentUser?.email}" +
//                             "${TruckLicense}" +
//                             "truckimage.png");

//                 DriverLicenseImageID =
//                     await UploadImages.uploadTruckDriverPictures(
//                         DriverLicenseImage!,
//                         "${currentUser?.email}" + "drivinglicense.png");

//                 DriverCINImageID = await UploadImages.uploadTruckDriverPictures(
//                     DriverCINImage!, "${currentUser?.email}" + "cin.png");

//                 if (!checkUpload) {
//                   Get.defaultDialog(
//                       title: "Error",
//                       titleStyle: TextStyle(
//                           fontSize: 30,
//                           color: Color(0xFFE40613),
//                           fontWeight: FontWeight.bold),
//                       middleText:
//                           "Some images can't be uploaded\n please try again ",
//                       middleTextStyle:
//                           TextStyle(color: Color(0xFF005b71), fontSize: 20));
//                 } else {
//                   await APIServiceConductor.RegisterConductor(
//                       currentUser?.username,
//                       currentUser?.email,
//                       userData.read("password"),
//                       TruckModel,
//                       TruckLicense,
//                       TruckLicenseImageID,
//                       TruckPhotoImageID,
//                       DriverLicenseImageID,
//                       DriverCINImageID);

//                   if (checkRegisterCondcuctor) {
//                     setState(() {
//                       currentStep += 1;
//                     });

//                     Fluttertoast.showToast(
//                         msg: "your request has been sent successfully",
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.BOTTOM,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: Color.fromARGB(255, 33, 125, 56),
//                         textColor: Colors.white,
//                         fontSize: 20.0);
//                     pending = true;
//                     isdriver = false;
//                   } else {
//                     Get.defaultDialog(
//                         title: "Error",
//                         titleStyle: TextStyle(
//                             fontSize: 30,
//                             color: Color(0xFFE40613),
//                             fontWeight: FontWeight.bold),
//                         middleText: "You can not be registred ",
//                         middleTextStyle:
//                             TextStyle(color: Color(0xFF005b71), fontSize: 20));
//                   }
//                 }
//               }