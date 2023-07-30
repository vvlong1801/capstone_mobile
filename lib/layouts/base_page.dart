import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/layouts/widgets/app_bar_widget.dart';

class BasePage extends ConsumerStatefulWidget {
  final Widget child;

  const BasePage({super.key, required this.child});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasePageState();
}

class _BasePageState extends ConsumerState<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarWidget(),
      body: SafeArea(child: widget.child),
    );
  }
}
