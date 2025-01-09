part of 'update_task_bloc.dart';

sealed class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object> get props => [];
}

final class UpdateTaskImageChanged extends UpdateTaskEvent {
  final String taskImage;

  const UpdateTaskImageChanged(this.taskImage);

  @override
  List<Object> get props => [taskImage];
}

final class UpdateTaskRequestedWithImage extends UpdateTaskEvent {
  final String? taskImage;
  final UpdateTaskRequest data;
  final String taskId;

  const UpdateTaskRequestedWithImage({
     this.taskImage,
    required this.data,
    required this.taskId,
  });
}

final class PriorityUpdated extends UpdateTaskEvent {
  final String priority;

  const PriorityUpdated(this.priority);

  @override
  List<Object> get props => [priority];
}

final class TaskProgressStatusUpdated extends UpdateTaskEvent {
  final String taskProgressStatus;

  const TaskProgressStatusUpdated(this.taskProgressStatus);

  @override
  List<Object> get props => [taskProgressStatus];
}
