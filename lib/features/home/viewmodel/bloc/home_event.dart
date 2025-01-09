part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeFilterChanged extends HomeEvent {
  final int selectedIndex;

  const HomeFilterChanged(this.selectedIndex);
}

final class AllTasksRequested extends HomeEvent {
  const AllTasksRequested();
}

final class GetTaskById extends HomeEvent {
  final String id;

  const GetTaskById(this.id);
}

final class ResetTaskRequested extends HomeEvent {
  const ResetTaskRequested();
}

final class RemoveTaskFromUI extends HomeEvent {
  final String taskId;

  const RemoveTaskFromUI(this.taskId);
}

final class UndoTaskDeletion extends HomeEvent {
  final TaskModel task;
  final int index; // Original position of the task

  const UndoTaskDeletion(this.task, this.index);
}

final class DeleteTaskRequested extends HomeEvent {
  final String taskId;

  const DeleteTaskRequested(this.taskId);
}
