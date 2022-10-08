import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:prayer/location/geo_location.dart';

class ApiServices {
  static late double pLat;
  static late double pLong;
  late LocationPermission permission;

  static Future<http.Response?> fetchData() async {

  final position = await geoLocation.getPTLocation();
  String date = DateTime.now().toIso8601String();

  pLat = position.latitude;
  pLong = position.longitude;
  print('this is the latitude $pLat');
  print('this is the longitude $pLong');
    String url =
        'http://api.aladhan.com/v1/timings/$date?latitude=$pLat&longitude=$pLong&method=5';

    http.Response response = await http.get(Uri.parse(url));
    return response;
  }
}
