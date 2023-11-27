import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/task_bloc/task_bloc.dart';
import 'package:todo_bloc/data/model/task.dart';

import '../widgets/tasks_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  static const id = 'favoriteScreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TaskState>(builder: (context, state) {
      List<Task> favoriteTasks = state.favoriteTasks;
      return TasksList(
        tasksList: favoriteTasks,
      );
    });
  }
}
