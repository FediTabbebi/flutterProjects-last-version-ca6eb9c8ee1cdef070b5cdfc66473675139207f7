import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

var imageID;
bool checkUpload = false;

class UploadImages {
  static Future uploadTruckDriverPictures(File imageFile, String ref) async {
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();

    var request = new http.MultipartRequest(
        "POST", Uri.parse('http://192.168.1.83:4000/image/upload'));
    var multipartFile = new http.MultipartFile('testImage', stream, length,
        filename: basename(imageFile.path));
    request.fields.addAll({'name': ref});

    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      var data = json.decode(await response.stream.bytesToString());

      imageID = data["_id"];
      checkUpload = true;
      return imageID;
    } else {
      checkUpload = false;
      return null;
    }
  }
}
