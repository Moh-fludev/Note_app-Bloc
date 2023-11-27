import 'package:flutter/material.dart';

import '../../bloc/bloc_extentions.dart';
import '../../data/model/task.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Add Task',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
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
                      child: const Text('Insert'),
                      onPressed: () {
                        var task = Task(
                            title: title.text,
                            description: description.text,
                            isDone: false,
                            isDeleted: false,
                            isFavorite: false
                            
                            );
                        context.read<TasksBloc>().add(AddTask(task: task));
                        Navigator.pop(context);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
