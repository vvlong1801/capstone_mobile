import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/widgets/workout/exit_dialog.dart';

class WorkoutAppBarWidget extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final Function? actionLeading;
  final Function? actionExit;
  final Function? actionContinue;
  final Function? actionReset;

  const WorkoutAppBarWidget(
      {super.key,
      this.actionLeading,
      this.actionContinue,
      this.actionExit,
      this.actionReset});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _WorkoutAppBarWidgetState extends ConsumerState<WorkoutAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      leading: InkWell(
        onTap: () {
          widget.actionLeading?.call();
          showDialog(
              context: context,
              builder: (context) {
                return ExitWorkout(
                  actionContinue: widget.actionContinue,
                  actionExit: widget.actionExit,
                  actionReset: widget.actionReset,
                );
              });
        },
        child: Icon(
          Icons.chevron_left_rounded,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
