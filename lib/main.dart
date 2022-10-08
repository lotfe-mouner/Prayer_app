import 'package:flutter/material.dart';
import 'package:prayer/bloc/data_cubit.dart';
import 'package:prayer/location/mapsScreen.dart';
import 'package:prayer/presentation/prayer_times.dart';
import '../presentation/Prayer_Screen.dart';
import './bloc/payer_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => PrayerCubit()),
      BlocProvider(
          create: (context) => DataCubit()..fetchData())
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrayerScreen(),
    ),);


  }
}
