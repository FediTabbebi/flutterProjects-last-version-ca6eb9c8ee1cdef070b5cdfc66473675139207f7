import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/Models/userOffers.dart';
import 'package:iblaze/data/globals.dart';

import '../../../../services/conductorServices/conductorOffreAPI.dart';

class RentHistory extends StatefulWidget {
  const RentHistory({Key? key}) : super(key: key);

  @override
  State<RentHistory> createState() => _RentHistoryState();
}

class _RentHistoryState extends State<RentHistory> {
  List<UserOffers> offers = [];
  @override
  void initState() {
    super.initState();

    init();
  }

  void init() async {
    final offersp =
        await APIOffreConductor.offreCompleted(currentConductor?.conductorId);
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
        onRefresh: ()async {
          init();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('History'),
            centerTitle: true,
            backgroundColor: Color(0xFF005b71),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                // child: Text("Your rent history",
                //     style: TextStyle(color: Color(0xFF005b71), fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    itemCount: offers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 60, left: 30.0, right: 30),
                        child: Container(
                          child: Card(
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
                                   
                                    child: ListTile(
                                      title:
                                      new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                     
                                         new TextSpan(text:offers[index].getResponse,style: GoogleFonts.roboto(
                                           // fontSize: 16,
                                            color: Colors.black,fontWeight:FontWeight.bold)) 
                                  ],
                                    
                                  ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 2,
                                 color :Color.fromARGB(255, 0, 90, 113),),
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
                                  Container(
                                    child: ListTile(
                                      title:
                                      Center(
                                        child: new RichText(
                                    text: new TextSpan(
                                  children: <TextSpan>[
                                        new TextSpan(text :"Date :  ",style: GoogleFonts.roboto(
                                             // fontSize: 16,
                                              color: Color(0xFF005b71),
                                              fontWeight: FontWeight.bold,), ),
                                           new TextSpan(text:"  ${offers[index].getDate}",style: GoogleFonts.roboto(
                                             // fontSize: 16,
                                              color: Color(0xFFF7B30c),fontWeight: FontWeight.bold,)) 
                                  ],
                                    
                                  ),
                                        ),
                                      ),
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
    );
  }
}
