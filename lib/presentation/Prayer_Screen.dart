import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/payer_cubit.dart';
import '../bloc/prayer_states.dart';
import '../notification_service/notification_service.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerCubit, PrayerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PrayerCubit.get(context);
          return Scaffold(
            extendBody: true,
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              // type: BottomNavigationBarType.fixed,
              // elevation: 0,
                backgroundColor: Colors.transparent,
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.changePage(index);
              },
            ),
          );
        });
  }
}
