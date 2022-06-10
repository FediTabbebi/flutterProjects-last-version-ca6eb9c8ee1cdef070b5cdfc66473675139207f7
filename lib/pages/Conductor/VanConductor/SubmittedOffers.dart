import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/Models/userOffers.dart';
import 'package:iblaze/data/globals.dart';

import '../../../Models/conductorOffers.dart';
import '../../../services/conductorServices/conductorOffreAPI.dart';

class conductorRegisteredOffers extends StatefulWidget {
  const conductorRegisteredOffers({Key? key}) : super(key: key);

  @override
  State<conductorRegisteredOffers> createState() =>
      _conductorRegisteredOffersState();
}

class _conductorRegisteredOffersState extends State<conductorRegisteredOffers> {
  List<RegisteredOffers> offers = [];
  List<RegisteredOffers> Rejectedoffers = [];
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    final offersp = await APIOffreConductor.allRegisteredOffers(
        currentConductor?.conductorId, "active");
  
    if (offersp != null) {
      setState(() {
        offers = offersp;
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: Color(0xFF005b71),
        onRefresh: () async {
          init();
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(62, 0, 90, 113),
                    Color.fromARGB(62, 255, 255, 255),
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Text("Your Propositions ",
                      style: TextStyle(
                          color: Color(0xFF005b71),
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView.builder(
                        itemCount: offers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  border: Border.all(
                                    color: Color(0xFF005b71),
                                    width: 1,
                                  )),
                              child: Card(
                                // shadowColor: Color.fromARGB(255, 255, 77, 65),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ExpansionTile(
                                  title: new RichText(
                                      text: new TextSpan(
                                    children: <TextSpan>[
                                      new TextSpan(
                                          text: offers[index].getDepart,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color: Color(0xFF005b71),
                                          )),
                                      new TextSpan(
                                          style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          text: '    To     '),
                                      new TextSpan(
                                          text: offers[index].getArrivee,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            color: Color(0xFF005b71),
                                          )),
                                    ],
                                  )),
                                  children: [
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Departure Location : " +
                                            offers[index].getDepart),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Arrival Location : " +
                                            offers[index].getArrivee),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Freight Type : " +
                                            offers[index].getFreightType),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Client description : " +
                                            offers[index].getUserDescription),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Quantity : " +
                                            offers[index].getQuantity),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Delivery time : " +
                                            "${offers[index].getDeliveryTime}"),
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text(offers[index].getResponse),
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        title: Text("Client Name : " +
                                            "${offers[index].getUsername}"),
                                      ),
                                    ),
                                    Container(
                                      height: 2,
                                      color: Color(0xFF005b71),
                                      child: ListTile(
                                        title: Text(offers[index].getResponse),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Your price : " +
                                            "  ${offers[index].getPrice}"),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Your description : " +
                                            " ${offers[index].getDescription}"),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Used truck : " +
                                            "  ${offers[index].getTruckName}"),
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () async {
                                        Get.defaultDialog(
                                            title: "Warning",
                                            titleStyle: TextStyle(
                                                fontSize: 30,
                                                color: Color(0xFFE40613)),
                                            middleText:
                                                "Are you sure you want to delete this proposition ! \n ",
                                            middleTextStyle:
                                                TextStyle(fontSize: 20),
                                            textCancel: "Cancel",
                                            cancelTextColor: Colors.black,
                                            textConfirm: "Confirm",
                                            confirmTextColor: Colors.white,
                                            buttonColor: Color(0xFFE40613),
                                            onConfirm: () async {
                                              await APIOffreConductor
                                                  .DeleteOffre(
                                                      offers[index].getOffreId);
                                              if (DeletedOffreConductor) {
                                                Get.back();
                                                setState(() {
                                                  offers.remove(offers[index]);
                                                });
                                                Get.defaultDialog(
                                                    title: "Done",
                                                    titleStyle: TextStyle(
                                                        fontSize: 30,
                                                        color: Color.fromARGB(
                                                            255, 10, 101, 13)),
                                                    middleText:
                                                        "Your proposition has been deleted !",
                                                    middleTextStyle: TextStyle(
                                                        color:
                                                            Color(0xFF005b71),
                                                        fontSize: 20));
                                              } else {
                                                Get.defaultDialog(
                                                    title: "Error",
                                                    titleStyle: TextStyle(
                                                        fontSize: 30,
                                                        color:
                                                            Color(0xFFE40613),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    middleText:
                                                        "Something went wrong !",
                                                    middleTextStyle: TextStyle(
                                                        color:
                                                            Color(0xFF005b71),
                                                        fontSize: 20));
                                              }
                                            });
                                      },
                                      title: Text("Delete",
                                          style: TextStyle(
                                              color: Color(0xFFE40613))),
                                      trailing: Icon(Icons.delete,
                                          color: Color(0xFFE40613)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
