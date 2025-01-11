part of 'task_details_bloc.dart';

sealed class TaskDetailsEvent extends Equatable {
  const TaskDetailsEvent();

  @override
  List<Object> get props => [];
}

final class DeleteTaskRequested extends TaskDetailsEvent {
  const DeleteTaskRequested(this.taskId);

  final String taskId;

  @override
  List<Object> get props => [taskId];
}
