import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

// Future<Album> fetchAlbum() async {
Future fetchProfile() async {
  final response = await http.get(Uri.parse(ipServer + '/guard/profile'));

  if (response.statusCode == 200) {
    print(response.body);
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Profile');
  }
}

Future getProfileImage(String path) async {
  final response = await http.post(Uri.parse(ipServer + '/guard/profile_image'),
      body: jsonEncode(<String, String>{"path": path}));

  print(response.statusCode);

  // final decodedResponse = json.decode(response.body);
  // print(decodedResponse);

  return response.body;
} 

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   const Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }
