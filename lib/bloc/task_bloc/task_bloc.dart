import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/data/model/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TasksBloc extends Bloc<TaskEvent, TaskState> {
  TasksBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<FavoriteTask>(_onFavoriteTask);
    on<RemoveTask>(_onRemoveTask);
    on<DeleteTask>(_onDeleteTask);
    on<RestoreTask>(_onRestoreTask);
    on<EditTask>(_onEditTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;

    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        removedTask: state.removedTask,
        favoriteTasks: state.favoriteTasks));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    var indexofTask = favoriteTasks.indexOf(task);

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isdoneCopied: true)),
            if (task.isFavorite == true)
              {
                favoriteTasks = List.from(favoriteTasks)
                  ..remove(task)
                  ..insert(indexofTask, task.copyWith(isdoneCopied: true))
              }
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isdoneCopied: false)),
            if (task.isFavorite == true)
              {
                favoriteTasks = List.from(favoriteTasks)
                  ..remove(task)
                  ..insert(indexofTask, task.copyWith(isdoneCopied: false))
              }
          };
    emit(TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTask: state.removedTask));
  }

  void _onFavoriteTask(FavoriteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        var indexTask = pendingTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(indexTask, task.copyWith(isFavoriteCopied: true));

        favoriteTasks = List.from(favoriteTasks)
          ..insert(0, task.copyWith(isFavoriteCopied: true));
      } else {
        var indexTask = pendingTasks.indexOf(task);

        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(indexTask, task.copyWith(isFavoriteCopied: false));
        favoriteTasks.remove(task);
      }
    } else {
      if (task.isFavorite == false) {
        var indexTask = completedTasks.indexOf(task);

        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(indexTask, task.copyWith(isFavoriteCopied: true));
        favoriteTasks = List.from(favoriteTasks)
          ..insert(0, task.copyWith(isFavoriteCopied: true));
      } else {
        var indexTask = completedTasks.indexOf(task);
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(indexTask, task.copyWith(isFavoriteCopied: false));
        favoriteTasks.remove(task);
      }
    }
    emit(TaskState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTask: state.removedTask));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;
    //this function is just deleted task from the third list

    emit(TaskState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTask: List.from(state.removedTask)
          ..insert(0, event.task.copyWith(isDeletedCopied: true))));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    //this function is deleted task for ever

    emit(TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTask: List.from(state.removedTask)..remove(event.task)));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTask = state.favoriteTasks;

    if (task.isDone == false) {
      pendingTasks = List.from(pendingTasks)
        ..insert(0, task.copyWith(isDeletedCopied: false));
      if (task.isFavorite == true) {
        favoriteTask = List.from(favoriteTask)
          ..insert(0, task.copyWith(isDeletedCopied: false));
      }
    } else if (task.isDone == true) {
      completedTasks = List.from(completedTasks)
        ..insert(0, task.copyWith(isDeletedCopied: false));
      if (task.isFavorite == true) {
        favoriteTask = List.from(favoriteTask)
          ..insert(0, task.copyWith(isDeletedCopied: false));
      }
    }

    emit(TaskState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTask,
      removedTask: List.from(state.removedTask)..remove(task),
    ));
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isDone == false) {
      pendingTasks = List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    } else if (event.oldTask.isDone == true) {
      favoriteTasks = List.from(state.favoriteTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    if (event.oldTask.isDone == true) {
      List.from(state.completedTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    // var indexpending = state.pendingTasks.indexOf(event.oldTask);
    // var indexcompl = state.completedTasks.indexOf(event.oldTask);
    // var indexfavo = state.favoriteTasks.indexOf(event.oldTask);
    emit(
      TaskState(
          pendingTasks: pendingTasks,
          completedTasks: completedTasks,
          favoriteTasks: favoriteTasks,
          removedTask: state.removedTask),
    );
  }
}
