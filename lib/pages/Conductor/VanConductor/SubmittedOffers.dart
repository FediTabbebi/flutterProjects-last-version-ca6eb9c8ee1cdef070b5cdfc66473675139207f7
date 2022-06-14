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
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         Color.fromARGB(62, 0, 90, 113),
            //         Color.fromARGB(62, 255, 255, 255),
            //       ]),
            // ),
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
                            child:  Card(
                              //semanticContainer: false,
                              shadowColor:  Color(0xFF005b71),
                              elevation: 15,
                             // color:  Color(0xFF005b71),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ExpansionTile(
                               // collapsedTextColor: Color(0xFF005b71),
                                trailing: Icon(Icons.arrow_drop_down_sharp,color: Color(0xFF005b71),size: 30,),
                                leading:  CircleAvatar(
  backgroundImage: AssetImage("images/LgiCon.png"),backgroundColor: Colors.white,),
                                title: new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                    // new TextSpan(
                                    //     style: new TextStyle(
                                    //       color: Colors.black,
                                    //     ),
                                    //     text: 'From '),
                                    new TextSpan(
                                        text: offers[index].getDepart,
                                        style: GoogleFonts.roboto(
                                         // fontSize: 18,
                                          color: Color(0xFF005b71),
                                          fontWeight: FontWeight.bold
                                        )),
                                    new TextSpan(
                                        style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        text: '    To     '),
                                    new TextSpan(
                                        text: offers[index].getArrivee,
                                        style: GoogleFonts.roboto(
                                         // fontSize: 18,
                                          color: Color(0xFF005b71),
                                         fontWeight: FontWeight.bold
                                        )),
                                  ],
                                )),
                                children: [
                                  
                                  Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Departure Location : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:offers[index].getDepart,style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Arrival Location : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:offers[index].getArrivee,style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Freight Type : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:offers[index].getFreightType,style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Client description : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:offers[index].getUserDescription,style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Quantity : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:offers[index].getQuantity,style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Delivery time :  ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:"${offers[index].getDeliveryTime}",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                     
                                         new TextSpan(text:offers[index].getResponse,style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,fontWeight: FontWeight.bold,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                                   Container(
                                    height: 2,
                                  color :Color.fromARGB(255, 0, 90, 113),
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Client Name : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:"${offers[index].getUsername}",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                                   Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Your price : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:"  ${offers[index].getPrice}",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                                   Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Your description : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:" ${offers[index].getDescription}",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                                   Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Used truck : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:"  ${offers[index].getTruckName}",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                              
                               
                              
                                  ListTile(
                                    onTap: () async {
                                      Get.defaultDialog(
                                          title: "Warning",
                                          titleStyle: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xFFE40613),fontWeight: FontWeight.bold,),
                                          middleText:
                                              "Are you sure you want to delete this proposition !  ",
                                          middleTextStyle:
                                              TextStyle(fontSize: 17.5,fontWeight: FontWeight.bold,),
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
                                            color: Color(0xFFE40613),fontWeight: FontWeight.bold)),
                                    trailing: Icon(Icons.delete,
                                        color: Color(0xFFE40613)),
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
