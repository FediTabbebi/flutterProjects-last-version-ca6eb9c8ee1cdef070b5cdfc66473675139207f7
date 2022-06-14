
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/Conductor/AddVehiclePage.dart';
import 'package:iblaze/pages/Conductor/VanConductor/conductorPage.dart';
import 'package:iblaze/services/conductorServices/truckAPI.dart';
import '../../../Models/truck.dart';


class VehicleManagement extends StatefulWidget {
  const VehicleManagement({Key? key}) : super(key: key);

  @override
  State<VehicleManagement> createState() => _VehicleManagementState();
}

class _VehicleManagementState extends State<VehicleManagement> {
  List<Truck> vehicles = [];
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    final trucks =
        await APITruckServices.getAllTrucks(currentConductor?.conductorId);
    if (trucks != null) {
      setState(() {
        vehicles = trucks;
      });
    }
  }

  // File? image;
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);
  //     setState(() => this.image = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image : $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        Get.to(() => VanConductor(index: 0));
        return true;
      },
      child: RefreshIndicator(
        color: Color(0xFF005b71),
        onRefresh: () async {
          init();
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(backgroundColor: Color(0xFF005b71),title: Text("Your vehicles"),centerTitle: true,),
            // backgroundColor: Color.fromARGB(255, 197, 188, 188),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Text("Your Vehicles ",
                //     style: TextStyle(
                //         color: Color(0xFF005b71),
                //         fontWeight: FontWeight.bold,
                //         fontSize: 30)),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ListView.builder(
                      itemCount: vehicles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30),
                          child: Container(
                            child: Card(
                                shadowColor:  Color(0xFF005b71),
                        elevation: 15,
                       // color:  Color
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15.0),
                                ),
                                child: ExpansionTile(
                                    leading: Icon(FontAwesomeIcons.truck,
                                        color: Color(0xFF005b71)),
                                        trailing: Icon(Icons.arrow_drop_down_sharp,color: Color(0xFF005b71),size: 30,),
                                    title: Text(
                                        "${vehicles[index].TruckModel} " +
                                            " ${vehicles[index].TruckLicense}",
                                        style: TextStyle(
                                            color: Color(0xFF005b71))),
                                    children: [
                                      // Container(
                                      //     child: image != null
                                      //         ? Image.file(
                                      //             image!,
                                      //             width: 100,
                                      //             height: 100,
                                      //           )
                                      //         : Image.asset('images/Lg.png',
                                      //             height: 100, width: 100)),
                                      ListTile(
                                        title: Text("Delete",
                                            style: TextStyle(
                                                color:
                                                    Color(0xFFE40613),fontWeight: FontWeight.bold)),
                                        trailing: Icon(Icons.delete,
                                            color: Color(0xFFE40613)),
                                        onTap: () async {
                                          Get.defaultDialog(
                                              title: "Warning",
                                              titleStyle: TextStyle(
                                                  fontSize: 25,
                                                  color:
                                                      Color(0xFFE40613),
                                                  fontWeight:
                                                      FontWeight.bold),
                                              middleText:
                                                  "Are you sure you want to remove this truck ! \n ",
                                              middleTextStyle:
                                                  TextStyle(fontSize: 17.5,fontWeight: FontWeight.bold),
                                              textCancel: "Cancel",
                                              cancelTextColor:
                                                  Colors.black,
                                              textConfirm: "Confirm",
                                              confirmTextColor:
                                                  Colors.white,
                                              buttonColor:
                                                  Color(0xFFE40613),
                                              onConfirm: () async {
                                               await APITruckServices
                                                    .DeleteTruck(
                                                        vehicles[index]
                                                            .TruckId,
                                                        currentConductor
                                                            ?.conductorId);


                                                if (truckDeletedCheck && !CantdeleteTruck) {
                                                  Get.back();
                                                  setState(() {
                                                    vehicles.remove(
                                                        vehicles[index]);
                                                  });
                                                  Get.defaultDialog(
                                                    title: "Done",
                                                    titleStyle: TextStyle(
                                                        fontSize: 30,
                                                        color: Color
                                                            .fromARGB(
                                                                255,
                                                                10,
                                                                101,
                                                                13),fontWeight: FontWeight.bold),
                                                    middleText:
                                                        "Your truck has been removed",
                                                    middleTextStyle:
                                                        TextStyle(
                                                            color: Color(
                                                                0xFF005b71),
                                                            fontSize: 17.5,fontWeight: FontWeight.bold),
                                                  );
                                                }  
                                               if ( truckDeletedCheck && CantdeleteTruck) {
                                                  
                                                  Get.defaultDialog(
                                                      title: "Error",
                                                      titleStyle: TextStyle(
                                                          fontSize: 25,
                                                          color: Color(
                                                              0xFFE40613),
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                      middleText:
                                                          " This truck can not be deleted \n (this truck is connected to a proposition)",
                                                      middleTextStyle:
                                                          TextStyle(
                                                              color: Color(
                                                                  0xFF005b71),
                                                              fontSize:
                                                                  17.5,fontWeight: FontWeight.bold));
                                                }
                                                 if (!truckDeletedCheck && !CantdeleteTruck   ) {
                                                   Get.defaultDialog(
                                                    title: "Error",
                                                    titleStyle: TextStyle(
                                                        fontSize: 25,fontWeight: FontWeight.bold,
                                                       color: Color(
                                                          0xFFE40613),
                                                                ),
                                                    middleText:
                                                        "Something went wrong",
                                                    middleTextStyle:
                                                        TextStyle(
                                                            color: Color(
                                                                0xFF005b71),
                                                            fontSize: 17.5,fontWeight: FontWeight.bold),
                                                  );
                                                }
                                              });
                                        },
                                      ),
                                    ])),
                          ),
                        );
                      }),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Align(
                //       // alignment: Alignment.bottomCenter,
                //       child: Container(
                //           height: 50,
                //           width: double.infinity,
                //           child: ElevatedButton.icon(
                //             onPressed: () {
                //               pickImage();
                //             },
                //             label: Text(
                //               "Add Image",
                //               style: GoogleFonts.roboto(
                //                   color: Colors.white, fontSize: 17.5),
                //             ),
                //             icon: Icon(Icons.add),
                //             style: ButtonStyle(
                //               backgroundColor:
                //                   MaterialStateProperty.all<Color>(
                //                 Color(0xFF005b71),
                //               ),
                //               foregroundColor:
                //                   MaterialStateProperty.all<Color>(
                //                       Colors.white),
                //               shape: MaterialStateProperty.all(
                //                   RoundedRectangleBorder(
                //                       borderRadius:
                //                           BorderRadius.circular(15.0))),
                //             ),
                //           ))),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.to(() => AddVehicle());
                            },
                            label: Text(
                              "Add Vehicle",
                              style: GoogleFonts.roboto(
                                  color: Colors.white, fontSize: 17.5),
                            ),
                            icon: Icon(Icons.add),
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
                                          BorderRadius.circular(15.0))),
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
