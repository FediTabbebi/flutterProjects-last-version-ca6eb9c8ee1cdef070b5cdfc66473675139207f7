import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/pages/CLient/ClientPage.dart';
import 'package:iblaze/pages/CLient/offers.dart';
import 'package:intl/intl.dart';

import '../../Models/userOffers.dart';
import '../../Widgets/button_widget.dart';
import '../../data/globals.dart';
import '../../services/userServices/Offre_Api.dart';

class updateOffre extends StatefulWidget {
  int index;
  updateOffre({required this.index});

  //const updateOffre({Key? key}) : super(key: key);

  @override
  State<updateOffre> createState() => _updateOffreState(index);
}

class _updateOffreState extends State<updateOffre> {
  int index;
  _updateOffreState(this.index);
  TextEditingController Quantity = TextEditingController();
  TextEditingController Arrival = TextEditingController();
  TextEditingController other = TextEditingController();
  TextEditingController Depart = TextEditingController();
  TextEditingController description = TextEditingController();

  DateTime dateTime = DateTime.now();
  String? dropdownvalue;
  bool isVisible = false;
  String? depart;
  String? arrivee;
  String? response;
  String? freightType;
  String? quantity;
  String? others;
  String? Description;
  String? DropdownValue;
  String? Oldquantity;
  String? Oldresponse;
  String? Olddepart;
  String? Oldarrivee;
  String? OldDescription;
  List<OffreModel> offer = [];
    List<String> dropDownBtnItem = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final offersp = await APIOffreUser.getOffers(currentUser?.id);
    if (offersp != null) {
      setState(() {
        offer = offersp;
        Oldquantity = offer[index].getQuantity;
        Oldresponse = offer[index].getResponse;
        Olddepart = offer[index].getDepart;
        Oldarrivee = offer[index].getArrivee;
        OldDescription = offer[index].getDescription;
        response = Oldresponse;
      });
    }
    final dropDownBtnItemContainer = await APIOffreUser.GetFreight();
    if (dropDownBtnItemContainer != null) {
      setState(() {
        dropDownBtnItem = dropDownBtnItemContainer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF005b71),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text("Edit your offer ",
                      style: TextStyle(color: Color(0xFF005b71), fontSize: 30)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Color(0xFF005b71), width: 2)),
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
                                    fontSize: 17.5,
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
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    child: TextFormField(
                      controller: other,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     if (others != null) {
                          //       other.text = "${others}";
                          //     }
                          //   },
                          //   icon: Icon(FontAwesomeIcons.arrowRotateLeft,
                          //       color: Color(0xFF005b71)),
                          // ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF005b71)),
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: TextFormField(
                    controller: description,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.locationDot,
                            color: Color.fromARGB(0, 0, 90, 113)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            description.text = "${OldDescription}";
                            Description = OldDescription;
                          },
                          icon: Icon(FontAwesomeIcons.arrowRotateLeft,
                              color: Color(0xFF005b71)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF005b71)),
                        ),
                        hintText: 'Description',
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
                      Description = value;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: TextFormField(
                    controller: Quantity,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.locationDot,
                            color: Color.fromARGB(0, 0, 90, 113)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            Quantity.text = "${Oldquantity}";
                            quantity = Oldquantity;
                          },
                          icon: Icon(FontAwesomeIcons.arrowRotateLeft,
                              color: Color(0xFF005b71)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF005b71)),
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: TextFormField(
                    controller: Depart,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () async {
                            Position position = await _getGeoLocationPosition();

                            await GetAddressFromLatLong(position);

                            Depart.text = "${depart}";
                          },
                          icon: Icon(FontAwesomeIcons.locationDot,
                              color: Color(0xFF005b71)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            Depart.text = "${Olddepart}";
                            depart = Olddepart;
                          },
                          icon: Icon(FontAwesomeIcons.arrowRotateLeft,
                              color: Color(0xFF005b71)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF005b71)),
                        ),
                        hintText: 'Departure Location',
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
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: TextFormField(
                    controller: Arrival,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        prefixIcon: Icon(FontAwesomeIcons.locationDot,
                            color: Color.fromARGB(0, 0, 90, 113)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            Arrival.text = "${Oldarrivee}";
                            arrivee = Oldarrivee;
                          },
                          icon: Icon(FontAwesomeIcons.arrowRotateLeft,
                              color: Color(0xFF005b71)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(width: 1, color: Color(0xFF005b71)),
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
                            pickDateTime(context);
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                  DateFormat(' MM/dd/yyyy HH:mm')
                                      .format(dateTime),
                                  style: TextStyle(fontSize: 17.5)),
                              SizedBox(width: 20),
                              Icon(Icons.edit, size: 17.5),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF005b71),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ))
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
                          style:
                              TextStyle(color: Color(0xFF005b71), fontSize: 15
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
                          style:
                              TextStyle(color: Color(0xFF005b71), fontSize: 15
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
                ButtonWidget(
                    text: "Update your offer",
                    onClicked: () async {
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
                                fontSize: 30,
                                color: Color(0xFFE40613),
                                fontWeight: FontWeight.bold),
                            middleText: "Check your offer",
                            middleTextStyle: TextStyle(
                                color: Color(0xFF005b71), fontSize: 20));
                      } else {
                        Get.defaultDialog(
                            title: "Check",
                            titleStyle: TextStyle(
                                fontSize: 30, color: Color(0xFF005b71)),
                            middleText:
                                "Freight Type : ${freightType} \n \n Description : ${Description} \n \n Quantity/Weight : ${quantity}  \n \n Departure Location : ${depart} \n \n Arrival Location : ${arrivee} \n \n  ${DateFormat(' MM/dd/yyyy HH:mm').format(dateTime)} ,  \n \n  ${response}  \n ",
                            textCancel: "Cancel",
                            cancelTextColor: Color(0xFF005b71),
                            textConfirm: "Confirm",
                            confirmTextColor: Colors.white,
                            buttonColor: Color(0xFF005b71),
                            onConfirm: () async {
                              await APIOffreUser.UpdateOffre(
                                  offer[index].getOffreId,
                                  depart,
                                  arrivee,
                                  response,
                                  DateFormat(' MM/dd/yyyy HH:mm')
                                      .format(dateTime)
                                      .toString(),
                                  freightType,
                                  quantity,
                                  Description);

                              if (UpdatedOffre) {
                                Fluttertoast.showToast(
                                    msg: "Your offer has been updated",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Color.fromARGB(255, 33, 125, 56),
                                    textColor: Colors.white,
                                    fontSize: 20.0);
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
                                  middleText: "Check your offer",
                                  middleTextStyle: TextStyle(
                                      color: Color(0xFF005b71), fontSize: 20),
                                );
                              }
                            });
                      }
                    }),
                SizedBox(height: 20)
              ],
            ),
          ),
        )),
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
