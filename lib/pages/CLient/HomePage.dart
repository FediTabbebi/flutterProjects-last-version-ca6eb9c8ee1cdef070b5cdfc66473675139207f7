import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/pages/CLient/ClientPage.dart';
import 'package:iblaze/pages/Conductor/LoginAs.dart';
import 'package:intl/intl.dart';
import '../../Widgets/button_widget.dart';
import '../../data/globals.dart';
import '../../services/userServices/Offre_Api.dart';
import '../../services/userServices/Register_Login.dart';
import '../Conductor/conductorLoginAs.dart';
import 'TruckMachine_page.dart';
import 'package:double_back_to_close/double_back_to_close.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController location = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController arrival = TextEditingController();
  TextEditingController other = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime timeBackPressed = DateTime.now();
  String? dropdownvalue;
  bool isVisible = false;
  String? depart;
  String? arrivee;
  String? response;
  String Description = "No description";

  String? freightType;
  String? quantity;
  DateTime dateTime = DateTime.now();
  List<String> dropDownBtnItem = [];
  late Timer timer;
  Color yellowColor=Color(0xFFF7B30c);

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => init());
    init();
  }

  init() async {
    final dropDownBtnItemContainer = await APIOffreUser.GetFreight();

    if (dropDownBtnItemContainer != null) {
      setState(() {
        dropDownBtnItem = dropDownBtnItemContainer;
      });
    }
    setState(() {
      response = "Only Delivering";
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: SingleChildScrollView(
          
          child: Padding(
            padding: const EdgeInsets.only(top:15),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
             Image.asset("images/Lg.png",height: 50,width: 50,),
          
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border:
                        Border.all(color: Color(0xFF005b71), width: 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    hint: Center(
                      child: Text(
                        "Choose your freight type",
                        style: TextStyle(
                          color: Color(0xFF005b71),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: dropdownvalue,
                    icon: Icon(Icons.keyboard_arrow_down,
                        color: Color(0xFF005b71), size: 30),
                    items: dropDownBtnItem.map((
                      String items,
                    ) {
                      return DropdownMenuItem(
                          value: items,
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              items,
                              style: TextStyle(
                                color: Color(0xFF005b71),
                               // fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ));
                    }).toList(),
                    onTap: () {},
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue;
                        freightType = newValue;
                        if (dropdownvalue == dropDownBtnItem.last) {
                          isVisible = true;
                          freightType = null;
                        } else {
                          isVisible = false;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: double.infinity,
                child: TextField(
                  controller: other,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            width: 1, color: Color(0xFFF7B30c),),
                      ),
                      hintText: 'Specify Your freight type ',
                      hintStyle: TextStyle(
                          //   fontSize: 20,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF005b71),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: (value) {
                    freightType = value;
                  },
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: TextField(
                controller: description,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          width: 1, color: Color(0xFFF7B30c),),
                    ),
                    hintText: 'Description (Optional)',
                    hintStyle: TextStyle(
                        //   fontSize: 20,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF005b71),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
                onChanged: (value) {
                  Description = value.trim();
                },
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: TextField(
                controller: weight,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          width: 1, color: Color(0xFFF7B30c),),
                    ),
                    hintText: 'Weight / Quantity',
                    hintStyle: TextStyle(
                        //   fontSize: 20,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF005b71),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
                onChanged: (value) {
                  quantity = value;
                },
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: TextField(
                controller: location,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        Position position =
                            await _getGeoLocationPosition();
        
                        await GetAddressFromLatLong(position);
                        if (depart != null) {
                          location.text = "${depart}";
                        }
                      },
                      icon: Icon(FontAwesomeIcons.locationDot,
                          color: Color(0xFF005b71)),
                    ),
                    prefixIcon: Icon(FontAwesomeIcons.locationDot,
                        color: Color.fromARGB(0, 0, 90, 113)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          width: 1, color: Color(0xFFF7B30c),),
                    ),
                    hintText: '           Departure Location',
                    hintStyle: TextStyle(
                        //   fontSize: 20,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF005b71),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
                onChanged: (value) {
                  depart = value;
                },
              ),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: TextField(
                controller: arrival,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          width: 1, color: Color(0xFFF7B30c),),
                    ),
                    hintText: 'Arrival Location ',
                    hintStyle: TextStyle(
                        //   fontSize: 20,
                        ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF005b71),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    )),
                onChanged: (value) {
                  arrivee = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        yellowColor=Color(0xFF005b71);
                        pickDateTime(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                              DateFormat('MM/dd/yyyy HH:mm ')
                                  .format(dateTime),
                              style: TextStyle(fontSize: 17.5)),
                          SizedBox(width: 20),
                          Icon(Icons.edit, size: 17.5),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        primary: Color.fromARGB(255, 0, 90, 113),
                      backgroundColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          side: BorderSide(
                             color: yellowColor,
                                   width: 0.5,
                             style: BorderStyle.solid
                               ), borderRadius: BorderRadius.circular(30)
                    
                          
                        ),
                        
                      )
                      )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Delivering And Unloading",
                      style: TextStyle(
                          color: Color(0xFF005b71), fontSize: 15
                          //fontWeight: FontWeight.bold,
                          ),
                    ),
                    Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xFF005b71)),
                        value: "Delivering And Unloading",
                        groupValue: response,
                        onChanged: (String? val) {
                          setState(() {
                            response = val;
                          });
                        }),
                    Text(
                      "Only Delivering",
                      style: TextStyle(
                          color: Color(0xFF005b71), fontSize: 15
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                    Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xFF005b71)),
                        value: "Only Delivering",
                        groupValue: response,
                        onChanged: (String? val) {
                          setState(() {
                            response = val;
                          });
                        })
                  ]),
            ),
            SizedBox(height: 20),
            Container(
           padding: EdgeInsets.only( left:75,right:70,bottom: 20),
          height: 60,
          width: double.infinity,
          child: ElevatedButton(
          onPressed:  () async {
                  if (Description == "") {
                    Description = "There is no description";
                  }
                  if (freightType == null ||
                      quantity == null ||
                      depart == null ||
                      arrivee == null ||
                      freightType == "" ||
                      quantity == "" ||
                      depart == "" ||
                      arrivee == "") {
                    Get.defaultDialog(
                        title: "Error",
                        titleStyle: TextStyle(
                          
                            fontSize: 25,
                            color: Color(0xFFE40613),
                            fontWeight: FontWeight.bold),
                            
                        middleText: "Check your offer !",
                        middleTextStyle: TextStyle(color: Color(0xFF005b71),
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold),radius : 20.0
                            );
                             
                  } else {
                    Get.defaultDialog(
                        title: "Check",
                        titleStyle: TextStyle(
                            fontSize: 30, color: Color(0xFF005b71)),
                        middleText:
                            "\n  Freight Type : ${freightType} \n \n Description : ${Description}\n \n Quantity/Weight : ${quantity}  \n \n Departure Location : ${depart} \n \n Arrival Location : ${arrivee} \n \n  ${DateFormat(' MM/dd/yyyy HH:mm ').format(dateTime)}   \n \n  ${response}  \n \n   ",
                        textCancel: "Cancel",
                        cancelTextColor: Color(0xFF005b71),
                        textConfirm: "Confirm",
                        confirmTextColor: Colors.white,
                        buttonColor: Color(0xFF005b71),
                        onConfirm: () async {
                          await APIOffreUser.RegisterOffre(
                              depart,
                              arrivee,
                              response,
                              DateFormat(' MM/dd/yyyy HH:mm ')
                                  .format(dateTime)
                                  .toString(),
                              freightType,
                              quantity,
                              currentUser?.id,
                              Description);
        
                          if (offreCheck) {
                            location.clear();
                            other.clear();
                            arrival.clear();
                            weight.clear();
                            description.clear();
                            Get.back();
                       
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ClientPage(index: 1)),
                            );
                          } else {
                            Get.back();
                            Get.defaultDialog(
                                title: "Error",
                                titleStyle: TextStyle(
                                    fontSize: 30,
                                    color: Color(0xFFE40613),
                                    fontWeight: FontWeight.bold),
                                middleText: "Something went wrong !",
                                middleTextStyle: TextStyle(
                                    color: Color(0xFF005b71),
                                    fontSize: 20));
                          }
                        });
                  }
                },
          child: Text("Look For Propositions",
            
            style: GoogleFonts.roboto(color: Colors.white, fontSize: 17.5),
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
            )),),
          //SizedBox(height: 10,)
               
          ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF005b71),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newDate == null) return null;

    return newDate;
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
          : initialTime,
    );

    if (newTime == null) return null;

    return newTime;
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    depart =
        '${place.street} ${place.subLocality} ${place.locality} ${place.postalCode} ${place.country}';
    setState(() {});
  }
}
