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
                                const EdgeInsets.only(left: 30.0, right: 30,bottom: 10),
                            child:Card(
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
                                  ),Container(
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
                                      new TextSpan(text :"Description : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:offers[index].getDescription,style: GoogleFonts.roboto(
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
                                    height: 2,
                                  color :Color.fromARGB(255, 0, 90, 113),
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                     
                                         new TextSpan(text:offers[index].getResponse,style: GoogleFonts.roboto(
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
                                      new TextSpan(text :"Conductor Name : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text: "${offers[index].getConductorName}",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    )),
                                  Container(
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                      new TextSpan(text :"Suggested price : ",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,), ),
                                         new TextSpan(text:"${offers[index].getPrice}",style: GoogleFonts.roboto(
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
                                      new TextSpan(text :"Conductor description : ",style: GoogleFonts.roboto(
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
                                         new TextSpan(text:"${offers[index].getTruckName}",style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                 
                                  ),
                                 
                                  Padding(
                                     padding: const EdgeInsets.only(top:15,bottom:15,left:8.0,right:8),
                                    child: Container(
                                           decoration: BoxDecoration(
                                            color: Color(0xFF005b71),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              )),
                                      child: ListTile(
                                        onTap: () async {
                                          Get.defaultDialog(
                                                        title: "Check",
                                                        titleStyle: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Color(0xFF005b71),
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        middleText:
                                                            "Are you sure you want to accept this proposition !  ",
                                                        middleTextStyle:
                                                            TextStyle(fontSize: 17.5, fontWeight:FontWeight.bold),
                                                        textCancel: "Cancel",
                                                        cancelTextColor:
                                                        Colors.black,
                                                        textConfirm: "Confirm",
                                                        confirmTextColor:
                                                            Colors.white,
                                                        buttonColor:
                                                            Color(0xFF005b71),
                                                             onConfirm: () async {
                                                              
                                          await APIOffreUser.Completeoffer(
                                              offers[index].getOffreId,
                                              offers[index].getUserOffreID);

                                          if (CompletingOffre) {
                                            Get.back();
                                            setState(() {
                                              offers.remove(offers[index]);
                                            });
                                            Get.defaultDialog(
                                                title: "Done",
                                                titleStyle: TextStyle(
                                                    fontSize: 25,
                                                    color: Color.fromARGB(255, 33, 125, 56),
                                                    fontWeight: FontWeight.bold),
                                                middleText:
                                                    "A notification has been sent to the transporter",
                                                middleTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.5,fontWeight:  FontWeight.bold));
                                          } else {
                                            Get.defaultDialog(
                                                title: "Error",
                                                titleStyle: TextStyle(
                                                    fontSize: 25,
                                                    color: Color(0xFFE40613),
                                                    fontWeight: FontWeight.bold),
                                                middleText:
                                                    "You can't Take this proposition !",
                                                middleTextStyle: TextStyle(
                                                    color: Color(0xFF005b71),
                                                    fontSize: 17.5,fontWeight:  FontWeight.bold));
                                          }
                                        },
                                          );
                                        },
                                        title: Center(
                                          child: Text("Take this proposition",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        trailing: Icon(FontAwesomeIcons.handshake,
                                            color: Colors.white),
                                            
                                      ),
                                    ),
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
