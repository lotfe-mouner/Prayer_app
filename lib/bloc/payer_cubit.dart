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
    PrayerTimes(),
    Settings(),
  ];
  int currentIndex = 0;
   List<Prayer>? finalData=[];

  List<bool> list = List.filled(6, false, growable: false);

  List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.access_time_filled), label: 'Prayers'),
    BottomNavigationBarItem(
        icon: Icon(Icons.hourglass_bottom), label: 'Settings')
  ];

  void changePage(index) {
    currentIndex = index;
    if (index == 0) PrayerTimes();
    if (index == 1) Settings();
    emit(BottomNavChange());
  }

   fetchData() async {
    try {
      emit(PrayerDataLoading());
       await ApiRepository.getData().then((values) => finalData=values);
      emit(PrayersDataLoaded());
    } catch (error) {
      emit(PrayersErrors(error: error));
      print(error);
    }
  }

}
