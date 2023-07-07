import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_side_final_project/layouts/controller/app_bar_controller.dart';
// import 'package:user_side_final_project/base/controller/app_bar_controller.dart';

class AppBarWidget extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends ConsumerState<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Demo",
        style: TextStyle(color: Colors.black87),
      ),
      leading: GoRouter.of(context).canPop()
          ? IconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.black87,
                size: 32,
              ),
              onPressed: () {
                // if (controller.actionBeforePop != null) {
                //   controller.actionBeforePop;
                // }
                GoRouter.of(context).pop();
              },
            )
          : null,
      // backgroundColor: Colors.deepPurple,
    );
  }
}
