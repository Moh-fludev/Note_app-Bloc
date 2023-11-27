import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_bloc/UI/widgets/tile_task.dart';

import 'package:todo_bloc/data/model/task.dart';

import '../../bloc/bloc_extentions.dart';

class TasksList extends StatelessWidget {
  const TasksList({required this.tasksList, super.key});
  final List<Task> tasksList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.purple[500],
              ),
              child: BlocBuilder<TasksBloc, TaskState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.pendingTasks.length > 1
                            ? '${state.pendingTasks.length} Tasks pending'
                            : '${state.pendingTasks.length} Task pending',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(' | '),
                      Text(
                        state.completedTasks.length > 1
                            ? '${state.completedTasks.length} Tasks Completed'
                            : '${state.completedTasks.length} Task Completed',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            tasksList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                        child: Text(
                      'No Tasks!!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    )),
                  )
                : ExpansionPanelList.radio(
                    animationDuration: const Duration(milliseconds: 900),
                    children: tasksList
                        .map((task) => ExpansionPanelRadio(
                            backgroundColor: Colors.purple[100],
                            value: Random(100),
                            headerBuilder: (context, isExpanded) =>
                                ListTileTask(task: task),
                            body: ListTile(
                              title: SelectableText.rich(TextSpan(children: [
                                TextSpan(
                                    text: '${task.description}\n',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ])),
                            )))
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}
