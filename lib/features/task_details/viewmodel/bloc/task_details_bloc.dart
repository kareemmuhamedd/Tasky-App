import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky_app/features/delete_task/repositories/delete_task_repository.dart';

part 'task_details_event.dart';

part 'task_details_state.dart';

class TaskDetailsBloc extends Bloc<TaskDetailsEvent, TaskDetailsState> {
  TaskDetailsBloc({
    required DeleteTaskRemoteRepository deleteTaskRemoteRepository,
  })  : _deleteTaskRemoteRepository = deleteTaskRemoteRepository,
        super(const TaskDetailsState.initial()) {
    on<DeleteTaskRequested>(_onDeleteTaskRequested);
  }

  final DeleteTaskRemoteRepository _deleteTaskRemoteRepository;

  void _onDeleteTaskRequested(
    DeleteTaskRequested event,
    Emitter<TaskDetailsState> emit,
  ) async {
    emit(state.copyWith(status: TaskDetailsStateStatus.loading));
    try {
      await _deleteTaskRemoteRepository.deleteTask(taskId: event.taskId);
      emit(state.copyWith(status: TaskDetailsStateStatus.taskDeleted));
    } catch (e) {
      emit(state.copyWith(status: TaskDetailsStateStatus.error));
    }
  }
}
