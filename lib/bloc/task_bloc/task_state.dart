part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> pendingTasks;
 final List<Task> completedTasks;
 final List<Task> favoriteTasks;
  final List<Task> removedTask;
  const TaskState({
    this.pendingTasks = const <Task>[],
        this.completedTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
    this.removedTask = const <Task>[],
  });

  @override
  List<Object> get props => [pendingTasks,completedTasks,favoriteTasks,removedTask];
}
