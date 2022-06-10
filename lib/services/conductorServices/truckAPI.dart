import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iblaze/Models/truck.dart';
import 'package:iblaze/data/globals.dart';

class APITruckServices {
  static RegisterTruck(truckModel, truckLicense) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://192.168.1.11:4000/conducteur/truck/register'));

    request.body =
        json.encode({"truckModel": truckModel, "truckLicense": truckLicense});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Data = json.decode(await response.stream.bytesToString());

      truckRegisterCheck = true;
      currentTruck = new Truck(Data["data"]["truckModel"],
          Data["data"]["truckLicense"], Data["data"]["id"]);
    } else {
      truckRegisterCheck = false;
      print(response.reasonPhrase);
    }
  }

  static AddTruck(
      conductorId, truckModel, truckLicense, truckpaper, truckimage) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PATCH',
        Uri.parse('http://192.168.1.11:4000/conducteur/truck/addtruck'));
    request.body = json.encode({
      "conducteur": conductorId,
      "truckModel": truckModel,
      "truckLicense": truckLicense,
      "truckPaper": truckpaper,
      "truckImage": truckimage,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      truckAddCheck = true;
    } else {
      truckAddCheck = false;
      print(response.reasonPhrase);
    }
  }

  static DeleteTruck(truckId, conductorId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('DELETE',
        Uri.parse('http://192.168.1.11:4000/conducteur/truck/deletetruck'));
    request.body = json.encode({"conducteur": conductorId, "truck": truckId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      truckDeletedCheck = true;
      CantdeleteTruck = false;
    } else if (response.statusCode == 400) {
      CantdeleteTruck = true;
      truckDeletedCheck = true;
      //print(CantdeleteTruck);

      // Data = json.decode(await response.stream.bytesToString());
    } else {
      truckDeletedCheck = false;
      CantdeleteTruck = false;

      print(response.reasonPhrase);
    }
  }

  static Future<List<Truck>> getAllTrucks(conductorID) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://192.168.1.11:4000/conducteur/truck/gettrucksbyconducteur'));
    request.body = json.encode({"conducteur": conductorID});
    request.headers.addAll(headers);
    List<Truck> alltrucks = [];
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Data = json.decode(await response.stream.bytesToString());

      // print(Data);
      for (var trucks in Data) {
        alltrucks.add(new Truck(
            trucks["truckModel"], trucks["truckLicense"], trucks["id"]));
      }
    } else {
      print(response.reasonPhrase);
    }
    return alltrucks;
  }

  static Future<List<String>> getTrucksName(conductorID) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://192.168.1.11:4000/conducteur/truck/gettrucksbyconducteur'));
    request.body = json.encode({"conducteur": conductorID});
    request.headers.addAll(headers);
    List<String> TruckItems = [];
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Data = json.decode(await response.stream.bytesToString());

      // print(Data);
      for (var trucks in Data) {
        TruckItems.add(trucks["truckModel"]);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TruckItems;
  }

  static Future<List<String>> getTrucksID(conductorID) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://192.168.1.11:4000/conducteur/truck/gettrucksbyconducteur'));
    request.body = json.encode({"conducteur": conductorID});
    request.headers.addAll(headers);
    List<String> TruckItems = [];
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Data = json.decode(await response.stream.bytesToString());

      // print(Data);
      for (var trucks in Data) {
        TruckItems.add(trucks["id"]);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TruckItems;
  }
}
