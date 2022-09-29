import 'package:http/http.dart' as http;


class ApiServices {
  static Future<http.Response?> fetchData() async {
    String url = 'http://api.aladhan.com/v1/timingsByCity?city=Cairo&country=Egypt&method=5';

    http.Response response = await http.get(Uri.parse(url));
    return response;
  }
}
