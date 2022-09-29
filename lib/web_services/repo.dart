import '../model/prayer.dart';
import 'api_service.dart';
import 'dart:convert';

class ApiRepository {
  ApiRepository();

  static Future<List<Prayer>?> getData() async {
     List<Prayer> finalData = [];
    try {
      final response = await ApiServices.fetchData();

      var extractedData = json.decode(response!.body);


      finalData.add(Prayer(
        name: 'Fajr',
        time: extractedData['data']['timings']['Fajr'].toString(),
        id: 1,
      ));
      finalData.add(Prayer(
        name: 'Sunrise',
        time: extractedData['data']['timings']['Sunrise'].toString(),
        id: 2,
      ));
      finalData.add(Prayer(
        name: 'Duhr',
        time: extractedData['data']['timings']['Dhuhr'].toString(),
        id: 3,
      ));
      finalData.add(Prayer(
        name: 'Asr',
        time: extractedData['data']['timings']['Asr'].toString(),
        id: 4,
      ));
      finalData.add(Prayer(
        name: 'Maghrib',
        time: extractedData['data']['timings']['Maghrib'].toString(),
        id: 5,
      ));
      finalData.add(Prayer(
        name: 'Isha',
        time: extractedData['data']['timings']['Isha'].toString(),
        id: 6,
      ));

      return finalData;
    } catch (error) {
      print(error);
    }
  }
}
