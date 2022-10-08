import 'package:geolocator/geolocator.dart';

class geoLocation {


  static Future getPTLocation() async {
    bool services = await Geolocator.isLocationServiceEnabled();
    if (!services) {
      await Geolocator.requestPermission();
    }

    
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
