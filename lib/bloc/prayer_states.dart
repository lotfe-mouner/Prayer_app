import '../model/prayer.dart';

abstract class PrayerStates {}

class Initial extends PrayerStates {}

class BottomNavChange extends PrayerStates {}


class PrayersErrors extends PrayerStates {
  final dynamic error;

  PrayersErrors({required this.error});
}
class PrayerDataLoading extends PrayerStates {}

class PrayersDataLoaded extends PrayerStates {
final List<Prayer>? loadedData;
PrayersDataLoaded({required this.loadedData});
}
