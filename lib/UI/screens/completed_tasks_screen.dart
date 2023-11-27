

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/task_bloc/task_bloc.dart';
import 'package:todo_bloc/data/model/task.dart';

import '../widgets/tasks_list.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});
  static const id = 'completedScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TaskState>(builder: (context, state) {
      List<Task> completedTasks = state.completedTasks;
      return TasksList(
        tasksList: completedTasks,
      );
    });
  }
}
