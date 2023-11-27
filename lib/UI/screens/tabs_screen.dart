import 'package:flutter/material.dart';
import 'package:todo_bloc/UI/screens/completed_tasks_screen.dart';
import 'package:todo_bloc/UI/screens/favorite_tasks_screen.dart';
import 'package:todo_bloc/UI/screens/pending_tasks_screen.dart';
import 'package:todo_bloc/UI/widgets/mydrawer.dart';

import 'task_add_form.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const id = 'tabsScreen';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var selectedindex = 0;
  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const AddTaskForm());
  }

  final List<Map<String, dynamic>> pages = [
    {'page_name': const PendingScreen(), 'title': 'Pending Tasks'},
    {'page_name': const CompletedScreen(), 'title': 'Completed Tasks'},
    {'page_name': const FavoriteScreen(), 'title': 'Favorite Tasks'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[500],
          title: Text(pages[selectedindex]['title'])),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedindex,
          onTap: (index) {
            setState(() {
              selectedindex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Pending',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Completed',
              icon: Icon(Icons.download_done_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Favorite',
              icon: Icon(Icons.favorite),
            ),
          ]),
      drawer: const MyDrawer(),
      body: pages[selectedindex]['page_name'],
      floatingActionButton: selectedindex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.purple[500],
              child: const Icon(Icons.add),
              onPressed: () {
                _addTask(context);
              })
          : null,
    );
  }
}
