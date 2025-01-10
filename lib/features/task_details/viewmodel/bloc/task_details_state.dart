part of 'task_details_bloc.dart';

enum TaskDetailsStateStatus {
  initial,
  loading,
  loaded,
  error,
  taskDeleted,
}

class TaskDetailsState extends Equatable {
  const TaskDetailsState._({
    this.status = TaskDetailsStateStatus.initial,
  });

  const TaskDetailsState.initial()
      : this._(
          status: TaskDetailsStateStatus.initial,
        );

  final TaskDetailsStateStatus status;

  TaskDetailsState copyWith({
    TaskDetailsStateStatus? status,
    bool? isDeleteButtonPressed,
  }) {
    return TaskDetailsState._(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
