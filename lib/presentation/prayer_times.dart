import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/payer_cubit.dart';
import '../bloc/prayer_states.dart';
import '../notification_service/notification_service.dart';
import '../shared/shared_prefs.dart';
import './Layout/main_layout.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({Key? key}) : super(key: key);

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
  late final NotificationHelper service;

  List<int> valueList = [5, 10, 15, 20, 25, 30];
  int remindAt = 0;
  int minutes = 0;

  late List<bool> currentList;

  @override
  void initState() {
    service = NotificationHelper();
    service.initializeNotification();
    currentList = PrayerCubit.get(context).list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerCubit, PrayerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var prayerList = PrayerCubit.get(context).finalData;
        print(currentList);
        return Scaffold(
          body: MainLayout(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Divider(
                  height: 30,
                  thickness: 2.0,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: prayerList?.length,
                    itemBuilder: (ctx, index) => buildCard(
                        prayerList![index].name,
                        prayerList[index].time,
                        prayerList[index].id,
                        index)),
              ],
            ),
          )),
        );
      },
    );
  }

  Padding buildCard(String name, String? time, int id, int index) {
    var viewedTime =
        DateFormat.jm().format(DateFormat("hh:mm").parse('$time:00'));
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 0.0,
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            Spacer(),
            Text(
              viewedTime,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            IconButton(
              icon: currentList[index]
                  ? const Icon(Icons.volume_up)
                  : const Icon(Icons.volume_off_outlined),
              onPressed: () async {
                setState(() {
                  currentList[index] = !currentList[index];
                });
                if (currentList[index] == true) {
                  await showErrorDialog(context);
                  if (minutes != 0) {
                    CacheHelper.putBoolean(
                        key: name, value: currentList[index]);
                    remindAt = int.parse(time!.split(':')[1]) - minutes;
                    print(remindAt);
                    service.scheduledNotification(
                      id: id,
                      hour: int.parse(time!.split(':')[0]),
                      minutes: remindAt,
                      sound: 'Pixie Dust',
                    );
                  } else {
                    setState(() {
                      currentList[index] = !currentList[index];
                    });
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future showErrorDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        insetPadding: EdgeInsets.zero,
        title: const Text('Remind before:'),
        content: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: ListWheelScrollView(
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: 20,
                  diameterRatio: 1,
                  useMagnifier: true,
                  magnification: 2,
                  perspective: 0.008,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      minutes = valueList[index];
                    });
                  },
                  children: [
                    ...valueList.map(
                      (eachVal) => Text(
                        eachVal.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Text(
                  'Minutes',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text(
              'Done',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              if (minutes == 0) minutes = 5;
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.redAccent),
            ),
            child: const Text(
              "Close",
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              minutes = 0;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
