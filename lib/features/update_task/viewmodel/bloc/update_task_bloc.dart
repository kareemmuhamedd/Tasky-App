import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky_app/features/create_task/repositories/create_task_repository.dart';
import 'package:tasky_app/features/update_task/models/update_task_request.dart';
import 'package:tasky_app/features/update_task/repositories/update_task_remote_repository.dart';

part 'update_task_event.dart';

part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc({
    required UpdateTaskRemoteRepository updateTaskRemoteRepository,
    required CreateTaskRepository createTaskRepository,
  })  : _updateTaskRemoteRepository = updateTaskRemoteRepository,
        _createTaskRepository = createTaskRepository,
        super(const UpdateTaskState.initial()) {
    on<UpdateTaskImageChanged>(_onTaskImageChanged);
    on<PriorityUpdated>(_onPriorityUpdated);
    on<TaskProgressStatusUpdated>(_onTaskProgressStatusChanged);
    on<UpdateTaskRequestedWithImage>(_onUpdateTaskRequestedWithImage);
  }

  final UpdateTaskRemoteRepository _updateTaskRemoteRepository;
  final CreateTaskRepository _createTaskRepository;

  void _onTaskImageChanged(
    UpdateTaskImageChanged event,
    Emitter<UpdateTaskState> emit,
  ) {
    emit(state.copyWith(image: event.taskImage));
  }

  void _onUpdateTaskRequestedWithImage(
      UpdateTaskRequestedWithImage event,
      Emitter<UpdateTaskState> emit,
      ) async {
    emit(state.copyWith(status: UpdateTaskStatus.loading));

    String? image;

    /// upload image first before update task
    /// because task update requires image url to be passed in the request
    if (event.taskImage != null) {
      final imageResult =
      await _createTaskRepository.uploadImage(imagePath: event.taskImage!);
      final String? imagePath = imageResult.fold(
            (failure) {
          emit(state.copyWith(
            status: UpdateTaskStatus.error,
            message: failure.message,
          ));
          return null;
        },
            (imagePath) => imagePath,
      );

      /// stop if image upload failed
      if (imagePath == null) return;
      image = imagePath; // Assign image after image upload
    }

    /// after image upload, process to create task
    final taskResult = await _updateTaskRemoteRepository.updateTask(
      data: event.data.copyWith(image: image),
      taskId: event.taskId,
    );
    taskResult.fold(
          (failure) => emit(state.copyWith(
        status: UpdateTaskStatus.error,
        message: failure.message,
      )),
          (task) => emit(state.copyWith(
        status: UpdateTaskStatus.success,
        message: 'Task updated successfully!',
      )),
    );
  }


  void _onPriorityUpdated(
    PriorityUpdated event,
    Emitter<UpdateTaskState> emit,
  ) {
    emit(state.copyWith(selectedPriority: event.priority));
  }

  void _onTaskProgressStatusChanged(
    TaskProgressStatusUpdated event,
    Emitter<UpdateTaskState> emit,
  ) {
    emit(state.copyWith(selectedProgressStatus: event.taskProgressStatus));
  }
}
