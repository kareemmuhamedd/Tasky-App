import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky_app/features/create_task/repositories/create_task_repository.dart';

import '../../model/create_task_request.dart';

part 'create_task_event.dart';

part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc({required CreateTaskRepository createTaskRepository})
      : _createTaskRepository = createTaskRepository,
        super(const CreateTaskState.initial()) {
    on<CreateTaskRequested>(_onCreateTaskRequested);
    on<PriorityChanged>(_onPriorityChanged);
    on<DueDateChanged>(_onDueDateChanged);
  }

  final CreateTaskRepository _createTaskRepository;

  void _onCreateTaskRequested(
      CreateTaskRequested event,
      Emitter<CreateTaskState> emit,
      ) async {
    emit(state.copyWith(status: CreateTaskStatus.loading));
    final result = await _createTaskRepository.createTask(data: event.data);
    result.fold(
          (failure) => emit(
        state.copyWith(
          status: CreateTaskStatus.error,
          message: failure.message,
        ),
      ),
          (task) => emit(
        state.copyWith(
          status: CreateTaskStatus.success,
          message: 'Task created successfully',
        ),
      ),
    );
  }

  void _onPriorityChanged(
      PriorityChanged event,
      Emitter<CreateTaskState> emit,
      ) {
    emit(state.copyWith(selectedPriority: event.priority));
  }

  void _onDueDateChanged(
      DueDateChanged event,
      Emitter<CreateTaskState> emit,
      ) {
    emit(state.copyWith(selectedDueDate: event.dueDate));
  }
}
