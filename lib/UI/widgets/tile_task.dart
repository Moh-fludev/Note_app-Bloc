import 'package:flutter/material.dart';
import 'package:todo_bloc/bloc/switch_bloc/switch_bloc.dart';
import 'package:todo_bloc/data/model/task.dart';

import '../../bloc/bloc_extentions.dart';

class ListTileTask extends StatelessWidget {
  const ListTileTask({required this.task, super.key});
  final Task task;
  void _removeOrDeleteTask(BuildContext cnx, Task task) {
    task.isDeleted == true
        ? cnx.read<TasksBloc>().add(DeleteTask(task: task))
        : cnx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context, Task oldTask) {
    TextEditingController title = TextEditingController(text: oldTask.title);
    TextEditingController description =
        TextEditingController(text: oldTask.description);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Update Task',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autofocus: true,
                  controller: title,
                  decoration: InputDecoration(
                      hintText: 'Tiitle',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple[500]!),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple[500]!),
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple[500]!),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple[500]!),
                          borderRadius: BorderRadius.circular(15))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                        color: Colors.purple[100],
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context)),
                    MaterialButton(
                        color: Colors.purple[400],
                        child: const Text('Update'),
                        onPressed: () {
                          var newtask = Task(
                              title: title.text,
                              description: description.text,
                              isDone: oldTask.isDone,
                              isDeleted: oldTask.isDeleted,
                              isFavorite: oldTask.isFavorite);

                          context.read<TasksBloc>().add(EditTask(oldTask: task,newTask: newtask));
                          Navigator.pop(context);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return ListTile(
          subtitle: Text(DateTime.now().toString().substring(0, 19)),
          leading: IconButton(
              onPressed: () {
                context.read<TasksBloc>().add(FavoriteTask(task: task));
              },
              icon: task.isFavorite == false
                  ? const Icon(Icons.star_border)
                  : const Icon(Icons.star)),
          title: Text(
            overflow: TextOverflow.ellipsis,
            task.title,
            style: TextStyle(
                color: state.switchValue ? Colors.white : Colors.black,
                decoration: task.isDone == true
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: (value) {
                  context.read<TasksBloc>().add(UpdateTask(task: task));
                },
              ),
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'Favorite') {
                    context.read<TasksBloc>().add(FavoriteTask(task: task));
                  }
                  if (value == 'Edit') {
                    _editTask(context, task);
                  }
                  if (value == 'Delete') {
                    _removeOrDeleteTask(context, task);
                  }
                  if (value == 'Restore') {
                    context.read<TasksBloc>().add(RestoreTask(task: task));
                  }
                  if (value == 'DeleteForever') {
                    _removeOrDeleteTask(context, task);
                  }
                },
                itemBuilder: task.isDeleted == false
                    ? (context) => [
                          PopupMenuItem(
                              value: 'Favorite',
                              child: Row(
                                children: [
                                  const Icon(Icons.bookmark_add),
                                  task.isFavorite == false
                                      ? const Text('Add to Favorite')
                                      : const Text('Remove as Favorite')
                                ],
                              )),
                          const PopupMenuItem(
                              value: 'Edit',
                              child: Row(
                                children: [Icon(Icons.edit), Text('Edit')],
                              )),
                          const PopupMenuItem(
                              value: 'Delete',
                              child: Row(
                                children: [Icon(Icons.delete), Text('Delete')],
                              )),
                        ]
                    : (context) => [
                          const PopupMenuItem(
                              value: 'Restore',
                              child: Row(
                                children: [
                                  Icon(Icons.restore),
                                  Text('Restore')
                                ],
                              )),
                          const PopupMenuItem(
                              value: 'DeleteForever',
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  Text('Delete Forever')
                                ],
                              )),
                        ],
              )
            ],
          ),
        );
      },
    );
  }
}
