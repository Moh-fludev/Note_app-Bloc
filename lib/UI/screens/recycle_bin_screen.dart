import 'package:flutter/material.dart';
import 'package:todo_bloc/UI/widgets/mydrawer.dart';
import 'package:todo_bloc/UI/widgets/tasks_list.dart';
import 'package:todo_bloc/bloc/bloc_extentions.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'RecycleBin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.purple[500],
          title: const Text('Recycle Bin')),
      body: BlocBuilder<TasksBloc, TaskState>(
        builder: (context, state) {
          return TasksList(tasksList: state.removedTask);
        },
      ),
    );
  }
}
