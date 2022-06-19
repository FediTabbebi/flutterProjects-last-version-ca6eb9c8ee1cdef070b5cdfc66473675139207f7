import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/Models/userOffers.dart';
import 'package:iblaze/data/globals.dart';

import '../../../services/conductorServices/conductorOffreAPI.dart';
import '../../Models/conductorOffers.dart';

class AcceptedOffers extends StatefulWidget {
  const AcceptedOffers({Key? key}) : super(key: key);

  @override
  State<AcceptedOffers> createState() => _AcceptedOffersState();
}

class _AcceptedOffersState extends State<AcceptedOffers> {
  List<UserOffers> offers = [];
  List<RegisteredOffers> Rejectedoffers = [];
  late Timer timer;
  @override
  void initState() {
    super.initState();
  timer = Timer.periodic(Duration(seconds: 1), (Timer t) => init());
    init();
  }
@override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  void init() async {
    final offersp =
        await APIOffreConductor.offreCompleted(currentConductor?.conductorId);
        final offersrejected = await APIOffreConductor.allRegisteredOffers(
        currentConductor?.conductorId, "rejected");
    if (offersp != null) {
      setState(() {
        offers = offersp;
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
        child:DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: new SafeArea(
              child: Column(
                children: <Widget>[
                  new Expanded(child: new Container()),
                  new TabBar(
                    tabs: [new Text("Accepted Propositions",style: TextStyle(color:Color(0xFF005b71),fontWeight: FontWeight.bold),), new Text("Declined Propositions",style: TextStyle(color: Color.fromARGB(255, 113, 13, 0),fontWeight: FontWeight.bold))],
                    indicatorColor: Color(0xFF005b71),  
                  ),
                ],
              ),
            ),
          ),
          body: new TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListView.builder(
                    itemCount: offers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 30.0, right: 30,bottom:5),
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
                                 color :Color.fromARGB(255, 0, 90, 113)),
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

                            ],
                          ),
                        ),
                      );
                    }),),
      /*******************************************************************************************************************************/
     /*******************************************************************************************************************************/ 
               Padding(
               padding: const EdgeInsets.only(top: 50),
               child: ListView.builder(
                   itemCount: Rejectedoffers.length,
                   itemBuilder: (BuildContext context, int index) {
                     return Padding(
                       padding:
                           const EdgeInsets.only(left: 30.0, right: 30,bottom:5),
                       child: Card(
                             //semanticContainer: false,
                             shadowColor:   Color(0xFF005b71),
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
                                       text: Rejectedoffers[index].getDepart,
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
                                       text: Rejectedoffers[index].getArrivee,
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
                                        new TextSpan(text:Rejectedoffers[index].getDepart,style: GoogleFonts.roboto(
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
                                        new TextSpan(text:Rejectedoffers[index].getArrivee,style: GoogleFonts.roboto(
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
                                        new TextSpan(text:Rejectedoffers[index].getFreightType,style: GoogleFonts.roboto(
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
                                        new TextSpan(text:Rejectedoffers[index].getUserDescription,style: GoogleFonts.roboto(
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
                                        new TextSpan(text:Rejectedoffers[index].getQuantity,style: GoogleFonts.roboto(
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
                                        new TextSpan(text:"${Rejectedoffers[index].getDeliveryTime}",style: GoogleFonts.roboto(
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
                                    
                                        new TextSpan(text:Rejectedoffers[index].getResponse,style: GoogleFonts.roboto(
                                          // fontSize: 16,
                                           color: Colors.black,fontWeight: FontWeight.bold,)) 
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
                                     new TextSpan(text :"Your price : ",style: GoogleFonts.roboto(
                                          // fontSize: 16,
                                           color: Colors.black,
                                           fontWeight: FontWeight.bold,), ),
                                        new TextSpan(text:"  ${Rejectedoffers[index].getPrice}",style: GoogleFonts.roboto(
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
                                        new TextSpan(text:" ${Rejectedoffers[index].getDescription}",style: GoogleFonts.roboto(
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
                                        new TextSpan(text:"  ${Rejectedoffers[index].getTruckName}",style: GoogleFonts.roboto(
                                          // fontSize: 16,
                                           color: Colors.black,)) 
                                 ],
                                   
                                 ),
                                     ),
                                   ),
                                 ),

                           ],
                         ),
                       ),
                     );
                   }),
                   )
            ],
          ),
        ),
      ),
    ));
  }
}