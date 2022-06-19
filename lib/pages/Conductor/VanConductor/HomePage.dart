import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iblaze/Models/conductorOffers.dart';
import 'package:iblaze/data/globals.dart';
import 'package:iblaze/pages/Conductor/LoginAs.dart';
import 'package:iblaze/pages/Conductor/VanConductor/conductorPage.dart';

import '../../../Models/userOffers.dart';
import '../../../Widgets/search_widget.dart';
import '../../../services/conductorServices/conductorOffreAPI.dart';
import '../../../services/conductorServices/truckAPI.dart';
import '../conductorLoginAs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController PriceController;
  var Price;
  String Description = "No description";
  String? TruckModel;
  String? dropdownvalue;
  var indexValue = null;
  String query = "";

  List<AllOffers> offers = [];

  List<AllOffers> searchingList = [];
  List<AllOffers> checkList=[];
  List<String> ChosenTruck = [];
  List<String> ChosenTruckId = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();

    PriceController = TextEditingController();
    //timer = Timer.periodic(Duration(seconds: 10), (Timer t) => init());
    init();
    initial();
    initialize();
  }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  void init() async {
    offers = await APIOffreConductor.getAllOffers(
        "${currentUser?.id}", "${currentConductor?.conductorId}");

    setState(() {
      searchingList = offers;
    });
  }
 

  void initial() async {
    final trucks =
        await APITruckServices.getTrucksName(currentConductor?.conductorId);
    if (trucks != null) {
      setState(() {
        this.ChosenTruck = trucks;
      });
    }
  }

  void initialize() async {
    final trucks =
        await APITruckServices.getTrucksID(currentConductor?.conductorId);
    if (trucks != null) {
      setState(() {
        this.ChosenTruckId = trucks;
      });
    }
  }

  Future ShowInformationDialog(BuildContext context, int index) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Form(
                          key: loginFormKey,
                          child: TextFormField(
                            controller: PriceController,
                            decoration: InputDecoration(
                              icon: Icon(
                                FontAwesomeIcons.moneyCheckDollar,
                                color: Color(0xFF005b71),
                              ),
                              hintText: "Name Your Price",
                              border: InputBorder.none,
                            ),
                            maxLines: 1,
                            onChanged: (value) {
                              Price = value;
                            },
                            onSaved: (value) {
                              Price = value!;
                            },
                            validator: (value) {
                              return validatePrice(value!);
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Add Description",
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            Description = value.trim();
                          },
                          maxLines: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, right: 10.0, left: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: Color(0xFF005b71), width: 2)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Center(
                                child: Text(
                                  "Select Your Vehcile",
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
                              items: ChosenTruck.map((
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
                                  TruckModel = newValue;
                                  indexValue = ChosenTruck.indexOf(newValue!);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: GestureDetector(
                            onTap: () async {
                              var x = check();
                              if (Description == null || Description == "") {
                                Description = "No description";
                              }
                              if (x==true && indexValue == null ) {
                                Get.defaultDialog(
                                    title: "Error",
                                    titleStyle: TextStyle(
                                        fontSize: 25,
                                        color: Color(0xFFE40613),
                                        fontWeight: FontWeight.bold),
                                    middleText:
                                        "You must select your vehicle ",
                                    middleTextStyle: TextStyle(
                                        color: Color(0xFF005b71),
                                        fontSize: 17.5, fontWeight: FontWeight.bold));
                              }
                              if (x==true && indexValue!=null) {
                                await APIOffreConductor.RegisterOffre(
                                    searchingList[index].getOffreId,
                                    currentConductor?.conductorId,
                                    ChosenTruckId[indexValue],
                                    Price,
                                    Description);
                                if (ConductorRegisteringOffre) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VanConductor(index: 1)),
                                    (Route<dynamic> route) => false,
                                  );
                                  // Fluttertoast.showToast(
                                  //     msg:
                                  //         "Your proposition has been submitted successfully",
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.BOTTOM,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: Colors.green,
                                  //     textColor: Colors.white,
                                  //     fontSize: 20.0);
                                }
                                if (!ConductorRegisteringOffre) {
                                Get.defaultDialog(
                                    title: "Error",
                                    titleStyle: TextStyle(
                                        fontSize: 25,
                                        color: Color(0xFFE40613),
                                        fontWeight: FontWeight.bold),
                                    middleText:
                                        "Your proposition can't be submitted !",
                                    middleTextStyle: TextStyle(
                                        color: Color(0xFF005b71),
                                        fontSize: 17.5, fontWeight: FontWeight.bold));
                              }
                              }  
                            },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                                color: Color(0xFF005b71),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.0))),
                            
                              child: Text(
                                "Sumbit",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Color(0xFF005b71),
      onRefresh: () async {
        initialize();
        initial();
        init();
        // setState(() {
        //   searchingList = offers;
        // });
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
          child: Column(
            children: [
              buildSearch(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                      itemCount: searchingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30),
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
                                      text: searchingList[index].getDepart,
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
                                      text: searchingList[index].getArrivee,
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
                                       new TextSpan(text:searchingList[index].getDepart,style: GoogleFonts.roboto(
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
                                       new TextSpan(text:searchingList[index].getArrivee,style: GoogleFonts.roboto(
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
                                       new TextSpan(text:searchingList[index].getFreightType,style: GoogleFonts.roboto(
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
                                       new TextSpan(text:searchingList[index].getUserDescription,style: GoogleFonts.roboto(
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
                                       new TextSpan(text:searchingList[index].getQuantity,style: GoogleFonts.roboto(
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
                                       new TextSpan(text:"${searchingList[index].getDeliveryTime}",style: GoogleFonts.roboto(
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
                                   
                                       new TextSpan(text:searchingList[index].getResponse,style: GoogleFonts.roboto(
                                         // fontSize: 16,
                                          color: Colors.black,fontWeight: FontWeight.bold,)) 
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
                                    new TextSpan(text :"Client Name : ",style: GoogleFonts.roboto(
                                         // fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,), ),
                                       new TextSpan(text:"${searchingList[index].getUsername}",style: GoogleFonts.roboto(
                                         // fontSize: 16,
                                          color: Colors.black,)) 
                                ],
                                  
                                ),
                                    ),
                                  ),
                                ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                   //height: 55,
                                           decoration: BoxDecoration(
                                              color: Color(0xFF005b71),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                             color: Colors.white,
                              width: 2,
                            )),
                                 child: ListTile(
                                      onTap: () async {
                                        await ShowInformationDialog(
                                            context, index);
                                        // Get.to(() => updateOffre(index: index));
                                        // print(index);
                                      },
                                      title: Center(
                                        child: Text("Take this offer",
                                            style: TextStyle(
                                                color: Colors.white,
                                                //fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                       trailing: Icon(FontAwesomeIcons.handHoldingDollar,
                                        color: Colors.white,
                                        //size: 20,
                                      ),
                                    )
                                    ),
                                  ),
                            
                                ],
                            
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool check() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      loginFormKey.currentState!.save();
      return true;
    }
  }

  String? validatePrice(String value) {
    if (value == null || value.isEmpty) {
      return "This Field can't be empty";
    }

    return null;
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search by Location',
        onChanged: searchOffre,
      );
  void searchOffre(String query) async {
    searchingList = await offers.where((offers) {
      final depart = offers.getDepart.toLowerCase();
      final arrive = offers.getArrivee.toLowerCase();
      final search = query.toLowerCase().trim();

      return depart.contains(search) || arrive.contains(search);
    }).toList();

    setState(() {
      //init();
      //this.query = query;
      // this.offers = searchingList;
    });
  }
}
