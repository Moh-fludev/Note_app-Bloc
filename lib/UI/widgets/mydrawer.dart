import 'package:flutter/material.dart';
import 'package:todo_bloc/UI/screens/recycle_bin_screen.dart';
import 'package:todo_bloc/UI/screens/tabs_screen.dart';
import 'package:todo_bloc/bloc/switch_bloc/switch_bloc.dart';

import '../../bloc/bloc_extentions.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(child: BlocBuilder<TasksBloc, TaskState>(
        builder: (context, state) {
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.purple),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.purple[300],
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                accountEmail: const Text('mohadavid25@gmail.com'),
                accountName: const Text('MohaDavid'),
              ),
              const Divider(
                color: Colors.purple,
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, TabsScreen.id);
                },
                leading: const Icon(Icons.note_add_sharp),
                trailing: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple[300],
                      borderRadius: BorderRadius.circular(15)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(
                    '${state.pendingTasks.length}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                title: const Text('All Notes'),
              ),
              ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, RecycleBin.id);
                  },
                  leading: const Icon(Icons.replay_circle_filled),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple[300],
                        borderRadius: BorderRadius.circular(15)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      ' ${state.removedTask.length}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  title: const Text('RecycleBin')),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Switch(
                      value: state.switchValue,
                      onChanged: (value) {
                        value
                            ? context.read<SwitchBloc>().add(SwitchOnEvent())
                            : context.read<SwitchBloc>().add(SwitchOffEvent());
                      });
                },
              )
            ],
          );
        },
      )),
    );
  }
}
