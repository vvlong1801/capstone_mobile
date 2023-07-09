import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remindOfDayData =
    StateProvider<List<bool>>((ref) => List.generate(7, (index) => true));

final remindTime = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());
