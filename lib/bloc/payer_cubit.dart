import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayer/bloc/prayer_states.dart';

import '../model/prayer.dart';
import '../web_services/repo.dart';
import '../presentation/prayer_times.dart';
import '../presentation/settings.dart';

class PrayerCubit extends Cubit<PrayerStates> {
  PrayerCubit() : super(Initial());

  static PrayerCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const PrayerTimes(),
    const Settings(),
  ];
  int currentIndex = 0;

  List<Prayer>? finalData = [];

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.access_time_filled), label: 'Prayers'),
    BottomNavigationBarItem(
        icon: Icon(Icons.hourglass_bottom), label: 'Settings')
  ];

  void changePage(index) {
    currentIndex = index;
    if (index == 0) {
      const PrayerTimes();
    }
    if (index == 1) const Settings();
    emit(BottomNavChange());
  }


}
