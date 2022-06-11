import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iblaze/pages/CLient/Register_page.dart';
import 'package:iblaze/pages/Conductor/AddVehiclePage.dart';
import 'package:iblaze/pages/Conductor/LoginAs.dart';
import 'package:iblaze/pages/Conductor/conductorLoginAs.dart';
import 'package:iblaze/pages/splash_screen.dart';
import 'package:iblaze/testing.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fade,

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: SplashScreen(title: 'Flutter'),
      // home: LoginAs(),
     //  home: testingChip()
    );
  }
}
