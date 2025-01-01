part of 'create_task_bloc.dart';

sealed class CreateTaskEvent extends Equatable {
  const CreateTaskEvent();

  @override
  List<Object> get props => [];
}

final class TaskImageChanged extends CreateTaskEvent {
  final String taskImage;

  const TaskImageChanged(this.taskImage);

  @override
  List<Object> get props => [taskImage];
}

final class CreateTaskRequestedWithImage extends CreateTaskEvent {
  final String taskImage;
  final CreateTaskRequest data;

  const CreateTaskRequestedWithImage({
    required this.taskImage,
    required this.data,
  });
}

final class PriorityChanged extends CreateTaskEvent {
  final String priority;

  const PriorityChanged(this.priority);

  @override
  List<Object> get props => [priority];
}

final class DueDateChanged extends CreateTaskEvent {
  final String dueDate;

  const DueDateChanged(this.dueDate);

  @override
  List<Object> get props => [dueDate];
}
