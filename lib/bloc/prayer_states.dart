import '../model/prayer.dart';

abstract class PrayerStates {}

class Initial extends PrayerStates {}

class BottomNavChange extends PrayerStates {}

class PrayerDataLoading extends PrayerStates {}

class PrayersDataLoaded extends PrayerStates {
  PrayersDataLoaded();
}

class PrayersErrors extends PrayerStates {
  final dynamic error;

  PrayersErrors({required this.error});
}

class IconValueChange extends PrayerStates{}