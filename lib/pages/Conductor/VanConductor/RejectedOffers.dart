import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/Models/userOffers.dart';
import 'package:iblaze/data/globals.dart';

import '../../../Models/conductorOffers.dart';
import '../../../services/conductorServices/conductorOffreAPI.dart';

class RejectedOffers extends StatefulWidget {
  const RejectedOffers({Key? key}) : super(key: key);

  @override
  State<RejectedOffers> createState() => _RejectedOffersState();
}

class _RejectedOffersState extends State<RejectedOffers> {
  List<RegisteredOffers> Rejectedoffers = [];
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    final offersrejected = await APIOffreConductor.allRegisteredOffers(
        currentConductor?.conductorId, "rejected");
    if (offersrejected != null) {
      setState(() {
        Rejectedoffers = offersrejected;
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
          body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Text("Declined Propositions ",
                    style: TextStyle(
                        color: Color(0xFF005b71),
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),

                /***************************************************************************************************************/
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ListView.builder(
                      itemCount: Rejectedoffers.length,
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
                                  color: Colors.red,
                                  width: 2,
                                )),
                            child: Card(
                              //  color: Color.fromARGB(112, 255, 0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ExpansionTile(
                                title: new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                    new TextSpan(
                                        text: Rejectedoffers[index].getDepart,
                                        style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          color: Colors.black,
                                        )),
                                    new TextSpan(
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        text: '    To     '),
                                    new TextSpan(
                                        text:
                                            Rejectedoffers[index].getArrivee,
                                        style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          color: Colors.black,
                                        )),
                                  ],
                                )),
                                children: [
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Departure Location : " +
                                              Rejectedoffers[index].getDepart,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Arrival Location : " +
                                              Rejectedoffers[index]
                                                  .getArrivee,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Freight Type : " +
                                              Rejectedoffers[index]
                                                  .getFreightType,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Client description : " +
                                              Rejectedoffers[index]
                                                  .getUserDescription,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Quantity : " +
                                              Rejectedoffers[index]
                                                  .getQuantity,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Delivery time : " +
                                              "${Rejectedoffers[index].getDeliveryTime}",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                          Rejectedoffers[index].getResponse,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                          "Client Name : " +
                                              "${Rejectedoffers[index].getUsername}",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    height: 2,
                                    color: Color(0xFF005b71),
                                    child: ListTile(
                                      title: Text(
                                          Rejectedoffers[index].getResponse,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Your price : " +
                                              "  ${Rejectedoffers[index].getPrice}",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Your description : " +
                                              " ${Rejectedoffers[index].getDescription}",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                    // height: 20,
                                    child: ListTile(
                                      title: Text(
                                          "Used truck : " +
                                              "  ${Rejectedoffers[index].getTruckName}",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
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
    );
  }
}
