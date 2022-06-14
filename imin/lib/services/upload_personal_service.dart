import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

Future uploadPersonal(String filename, String classCard) async {
  var uri = ipServerIminService + '/decode_image/';
  var request = new http.MultipartRequest("POST", Uri.parse(uri));

  request.files.add(
    http.MultipartFile(
      'image',
      File(filename).readAsBytes().asStream(),
      File(filename).lengthSync(),
      // filename: filename.split("/").last,
      filename: classCard,
    ),
  );

  return await request.send();

  // var res = await request.send();
  // print(res);
  // print(res.statusCode);
  // print(res.reasonPhrase);

  // res.stream.transform(utf8.decoder).listen((value) {
  //   var json = jsonDecode(value);
  //   print(json);
  //   print(json.runtimeType);
  //   print(json['firstname']);
  // });
}
