import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/models/personal_trainer.dart';
import 'package:user_side_final_project/providers/explore/controllers/personal_trainer_controller.dart';
import 'package:user_side_final_project/widgets/explore/personal_trainer_tile.dart';

class ListPersonalTrainerPage extends ConsumerStatefulWidget {
  const ListPersonalTrainerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListPersonalTrainerPageState();
}

class _ListPersonalTrainerPageState
    extends ConsumerState<ListPersonalTrainerPage> {
  late AsyncValue listPersonalTrainer;
  @override
  void initState() {
    super.initState();
    listPersonalTrainer = ref.refresh(listPersonalTrainerProvider);
  }

  @override
  Widget build(BuildContext context) {
    listPersonalTrainer = ref.watch(listPersonalTrainerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("List personal trainers"),
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(14),
              child: listPersonalTrainer.when(data: (data) {
                return ListView(
                  children: [
                    ...generateListPersonalTrainer(data),
                  ],
                );
              }, error: (error, _) {
                return Center(
                  child: Text(error.toString()),
                );
              }, loading: () {
                return Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                );
              }))),
    );
  }

  List<Widget> generateListPersonalTrainer(List<PersonalTrainer> listPT) {
    return listPT.map<Widget>((pt) => PersonalTrainerTile(pt: pt)).toList();
  }
}
