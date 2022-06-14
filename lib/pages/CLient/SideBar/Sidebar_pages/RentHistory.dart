import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Models/userOffers.dart';
import '../../../../data/globals.dart';
import '../../../../services/userServices/Offre_Api.dart';

class RentHistory extends StatefulWidget {
  const RentHistory({Key? key}) : super(key: key);

  @override
  State<RentHistory> createState() => _RentHistoryState();
}

class _RentHistoryState extends State<RentHistory> {
  List<UserOffers> offers = [];
  //bool completedOffer = false;
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    final offersp =
        await APIOffreUser.AcceptedOffers(currentUser?.id, "finished");
    setState(() {
      offers = offersp;
    });
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
          appBar: AppBar(
            title: const Text('History'),
            centerTitle: true,
            backgroundColor: Color(0xFF005b71),
          ),
          body: Container(
         
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView.builder(
                        itemCount: offers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Container(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
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
                                        title: Text("Your description : " +
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
                                      // height: 20,
                                      child: ListTile(
                                        title: Text(
                                            "${offers[index].getResponse}"),
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
                                        title: Text("Conductor Name : " +
                                            "  ${offers[index].getConductorName}"),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Suggested price : " +
                                            "  ${offers[index].getPrice}"),
                                      ),
                                    ),
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text("Conductor description : " +
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
                                    Container(
                                      // height: 20,
                                      child: ListTile(
                                        title: Text(
                                            "Date :  " +
                                                "  ${offers[index].getDate}",
                                            style: TextStyle(
                                                color: Color(0xFF005b71),
                                                fontSize: 17)),
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
      ),
    );
  }
}
