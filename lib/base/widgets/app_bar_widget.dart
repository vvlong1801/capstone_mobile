import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      title: const Text("demo"),
      leading: GoRouter.of(context).canPop()
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => GoRouter.of(context).pop(),
            )
          : null,
      backgroundColor: Colors.deepPurple,
    );
  }
}
