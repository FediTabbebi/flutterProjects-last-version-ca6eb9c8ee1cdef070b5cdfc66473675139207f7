import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iblaze/Models/conductor.dart';
import 'package:iblaze/data/globals.dart';

import '../userServices/Register_Login.dart';

String creationDate = "";
var Pending;

class APIServiceConductor {
  static RegisterConductor(username, email, password, truckModel, truckLicense,
      truckPaper, truckImage, drivingLicense, cin) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.1.11:4000/conducteur/register'));
    request.body = json.encode({
      "username": username,
      "email": email,
      "password": password,
      "truckModel": truckModel,
      "truckLicense": truckLicense,
      "cin": cin,
      "drivingLicense": drivingLicense,
      "truckImage": truckImage,
      "truckPaper": truckPaper,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      checkRegisterCondcuctor = true;
    } else {
      print(response.reasonPhrase);
      checkRegisterCondcuctor = false;
    }
  }

  static LoginConductor(email, password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.1.11:4000/conducteur/login'));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      checkLoginCondcuctor = true;
      var Data = json.decode(await response.stream.bytesToString());

var date = Data["data"]["date"];

      creationDate = date.substring(0, 10);
      currentConductor = new Conductor(
        Data["data"]["username"],
        Data["data"]["email"],
        //  Data["data"]["password"],
        Data["data"]["truck"],
        creationDate,
        Data["data"]["id"],
        Data["data"]["status"],
      );
    } else {
      print(response.reasonPhrase);
      checkLoginCondcuctor = false;
    }
  }
}
