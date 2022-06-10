import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/Models/userOffers.dart';
import 'package:iblaze/data/globals.dart';
import '../../../services/userServices/Offre_Api.dart';

class UserAcceptedOffers extends StatefulWidget {
  const UserAcceptedOffers({Key? key}) : super(key: key);

  @override
  State<UserAcceptedOffers> createState() => _UserAcceptedOffersState();
}

class _UserAcceptedOffersState extends State<UserAcceptedOffers> {
  List<UserOffers> offers = [];
  bool completedOffer = false;
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    final offersp = await APIOffreUser.AcceptedOffers(
      currentUser?.id,"active"
    );
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
                  Text("Propositions ",
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
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
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
                                  ListTile(
                                    onTap: () async {
                                      await APIOffreUser.Completeoffer(
                                          offers[index].getOffreId,
                                          offers[index].getUserOffreID);

                                      if (CompletingOffre) {
                                        setState(() {
                                          offers.remove(offers[index]);
                                        });
                                        Get.defaultDialog(
                                            title: "Done",
                                            titleStyle: TextStyle(
                                                fontSize: 30,
                                                color: Color.fromARGB(
                                                    255, 10, 101, 13),
                                                fontWeight: FontWeight.bold),
                                            middleText:
                                                "We will inform the conductor",
                                            middleTextStyle: TextStyle(
                                                color: Color(0xFF005b71),
                                                fontSize: 20));
                                      } else {
                                        Get.defaultDialog(
                                            title: "Error",
                                            titleStyle: TextStyle(
                                                fontSize: 30,
                                                color: Color(0xFFE40613),
                                                fontWeight: FontWeight.bold),
                                            middleText:
                                                "You can't Take this offer!",
                                            middleTextStyle: TextStyle(
                                                color: Color(0xFF005b71),
                                                fontSize: 20));
                                      }
                                    },
                                    title: Text("Accept this deal",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    trailing: Icon(FontAwesomeIcons.check,
                                        color: Colors.green),
                                  ),
                                ],
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
