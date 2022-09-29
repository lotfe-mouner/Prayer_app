import 'package:flutter/material.dart';
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
    return BlocProvider<PrayerCubit>(
      create: (context) => PrayerCubit()..fetchData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PrayerScreen(),
      ),
    );
  }
}
