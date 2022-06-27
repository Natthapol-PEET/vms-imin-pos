import 'package:http/http.dart' as http;
import 'package:imin/helpers/configs.dart';

gateController(String urlControl) async {
  var client = http.Client();
  var url = Uri.parse(urlControl);

  try {
    final response = await client.get(url, headers: headers);

    print("gateController: ${response.statusCode}");

    return response.statusCode;
  } catch (e) {
    print(e);
  }
}
