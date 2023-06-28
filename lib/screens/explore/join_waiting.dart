import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinWaitingPage extends ConsumerWidget {
  const JoinWaitingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(child: Center(child: Text("waiting"),),);
  }
}