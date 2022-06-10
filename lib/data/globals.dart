library iblaze.globals;

import 'package:get_storage/get_storage.dart';
import 'package:iblaze/Models/conductor.dart';
import 'package:iblaze/Models/user.dart';
import '../Models/conductorOffers.dart';
import '../Models/truck.dart';

User? currentUser = null;
Truck? currentTruck = null;
List<AllOffers> AllOffres = <AllOffers>[];
Conductor? currentConductor = null;
final userData = GetStorage();
bool checkLogin = false;
bool checkRegister = false;
bool checkUpdate = false;
bool updateName = false;
bool CantdeleteTruck = false;
bool checkLoginCondcuctor = false;
bool checkRegisterCondcuctor = false;
bool deletedUser = false;
bool UpdatedOffre = false;
bool truckRegisterCheck = false;
bool truckAddCheck = false;
bool truckDeletedCheck = false;
bool ConductorRegisteringOffre = false;
bool DeletedOffreConductor = false;
bool CompletingOffre = false;
