import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iblaze/Models/user.dart';
import 'package:iblaze/data/globals.dart';

bool checkup = false;

var items;
String creationDate = "";
bool pending = false;
bool Rejected = false;
bool isdriver = false;

bool isconductor = false;
bool isDeleted = false;

class APIServiceUser {
  static Future<void> login(email, password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.1.44:4000/users/login'));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      checkLogin = true;
      deletedUser = false;
      var Data = json.decode(await response.stream.bytesToString());

      var date = Data["data"]["date"];

      creationDate = date.substring(0, 10);

      currentUser = new User(
        Data["data"]["username"],
        Data["data"]["email"],
        Data["data"]["password"],
        creationDate,
        Data["data"]["id"],
        Data["data"]["isdriver"],
      );
      if (currentUser?.Status == "pending") {
        pending = true;
        Rejected = false;
        isconductor = false;
        isdriver = false;
        isDeleted = false;
      } else if (currentUser?.Status == "rejected") {
        Rejected = true;
        pending = false;
        isconductor = false;
        isdriver = false;
        isDeleted = false;
      } else if (currentUser?.Status == "none") {
        isdriver = true;
        pending = false;
        Rejected = false;
        isconductor = false;
        isDeleted = false;
      } else if (currentUser?.Status == "active") {
        Rejected = false;
        pending = false;
        isconductor = true;
        isdriver = false;
        isDeleted = false;
      } else if (currentUser?.Status == "deleted") {
        Rejected = false;
        pending = false;
        isconductor = false;
        isdriver = false;
        isDeleted = true;
      }
    } else if (response.statusCode == 403) {
      var e = json.decode(await response.stream.bytesToString());
      print(e);
      deletedUser = true;
      checkLogin = true;
    } else {
      print(response.reasonPhrase);
      checkLogin = false;
    }
  }

  static Register(username, email, password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.1.44:4000/users/register'));
    request.body = json
        .encode({"username": username, "email": email, "password": password});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      checkRegister = true;
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      checkRegister = false;
    }
  }

  static Update(userID, Username) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PATCH', Uri.parse('http://192.168.1.44:4000/users/update'));
    request.body = json.encode({
      "username": Username,
      "user": userID,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      checkUpdate = true;
      var Data = json.decode(await response.stream.bytesToString());
      var l = Data["data"];

      currentUser = new User(
        l,
        currentUser?.email,
        currentUser?.password,
        currentUser?.creationDate,
        currentUser?.id,
        currentUser?.Status,
      );
    } else {
      print(response.reasonPhrase);
      checkUpdate = false;
    }
  }

  // static Future UserStatus(UserID) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var request =
  //       http.Request('POST', Uri.parse("http://192.168.1.44:4000/user/status"));
  //   request.body = json.encode({"user": UserID});
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     var Data = json.decode(await response.stream.bytesToString());

  //     var Status = Data["isdriver"];
  //     currentUser?.Status = Status;

  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
}
