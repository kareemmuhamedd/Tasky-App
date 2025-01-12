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
    on<TaskImageChanged>(_onTaskImageChanged);
    on<PriorityChanged>(_onPriorityChanged);
    on<DueDateChanged>(_onDueDateChanged);
    on<CreateTaskRequestedWithImage>(_onCreateTaskRequestedWithImage);
  }

  final CreateTaskRepository _createTaskRepository;

  void _onTaskImageChanged(
    TaskImageChanged event,
    Emitter<CreateTaskState> emit,
  ) {
    emit(state.copyWith(image: event.taskImage));
  }

  void _onCreateTaskRequestedWithImage(
    CreateTaskRequestedWithImage event,
    Emitter<CreateTaskState> emit,
  ) async {
    emit(state.copyWith(status: CreateTaskStatus.loading));

    /// Check internet connection
    // final isConnected = await _createTaskRepository.isConnected();
    // if (!isConnected) {
    //   emit(state.copyWith(
    //     status: CreateTaskStatus.error,
    //     message: 'No internet connection. Please try again later.',
    //   ));
    //   return;
    // }

    /// upload image first before creating task
    /// because task creation requires image url to be passed in the request
    final imageResult =
        await _createTaskRepository.uploadImage(imagePath: event.taskImage);
    final String? imagePath = imageResult.fold(
      (failure) {
        emit(state.copyWith(
          status: CreateTaskStatus.error,
          message: failure.message,
        ));
        return null;
      },
      (imagePath) => imagePath,
    );

    /// stop if image upload failed
    if (imagePath == null) return;

    /// after image upload, process to create task
    final taskResult = await _createTaskRepository.createTask(
      data: event.data.copyWith(
        image: imagePath,
      ),
    );
    taskResult.fold(
      (failure) => emit(state.copyWith(
        status: CreateTaskStatus.error,
        message: failure.message,
      )),
      (task) => emit(state.copyWith(
        status: CreateTaskStatus.success,
        message: 'Task created successfully',
      )),
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
