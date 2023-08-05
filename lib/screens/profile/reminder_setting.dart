import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/notifications/local_notification.dart';
import 'package:user_side_final_project/providers/setting/reminder_controller.dart';

class ReminderSettingPage extends ConsumerStatefulWidget {
  const ReminderSettingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReminderSettingPageState();
}

class _ReminderSettingPageState extends ConsumerState<ReminderSettingPage> {
  List<String> daysOfWeek = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  @override
  Widget build(BuildContext context) {
    var remindDays = ref.watch(remindOfDayData);
    var time = ref.watch(remindTime);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reminder",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 100,
                child: Text(
                  "${time.hourOfPeriod.toString()}:${time.minute.toString().padLeft(2, "0")} ${time.period == DayPeriod.am ? "AM" : "PM"}",
                  style: const TextStyle(
                      fontSize: 60, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: remindDays.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () {
                          remindDays[index] = !remindDays[index];
                          ref.read(remindOfDayData.notifier).state =
                              List.from(remindDays);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Container(
                            color: remindDays[index]
                                ? Colors.deepPurple
                                : Colors.white,
                            child: SizedBox(
                              width: 50,
                              height: 40,
                              child: Center(
                                child: Text(
                                  daysOfWeek[index],
                                  style: TextStyle(
                                      color: remindDays[index]
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            TextButton(
                onPressed: () async {
                  // await LocalNotificationService()
                  //     .showLocalNotification(title: "test", body: "It work!");
                  ref
                      .watch(notificationServiceProvider)
                      .showLocalNotification(title: "test", body: "It work!");
                },
                child: const Text("test Notification"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () async {
          TimeOfDay? newTime =
              await showTimePicker(context: context, initialTime: time);
          ref.read(remindTime.notifier).update((state) => newTime ?? state);
          final mappedIndex = remindDays
              .mapIndexed((index, element) => element ? index + 1 : 0)
              .toList();
          final scheduledDays =
              mappedIndex.where((element) => element != 0).toList();
          if (newTime != null) {
            final now = DateTime.now();
            ref.watch(notificationServiceProvider).showScheduledNotification(
                title: "Remind Workout Time",
                body: "Let's start workout now!!",
                scheduledDate: DateTime(
                    now.year, now.month, now.day, newTime.hour, newTime.minute),
                days: scheduledDays);
          }
        },
        child: const Icon(
          Icons.alarm_add_outlined,
          size: 40,
        ),
      ),
    );
  }
}
