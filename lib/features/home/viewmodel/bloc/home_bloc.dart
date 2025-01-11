import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/delete_task/repositories/delete_task_repository.dart';
import 'package:tasky_app/features/home/repositories/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required HomeRemoteRepository homeRemoteRepository,
    required DeleteTaskRemoteRepository deleteTaskRemoteRepository,
  })  : _homeRemoteRepository = homeRemoteRepository,
        _deleteTaskRemoteRepository = deleteTaskRemoteRepository,
        super(const HomeState.initial()) {
    on<HomeFilterChanged>(_onFilterChanged);
    on<AllTasksRequested>(_onAllTasksRequested);
    on<GetTaskById>(_getTaskById);
    on<ResetTaskRequested>(_resetTaskRequested);
    on<DeleteTaskRequested>(_deleteTaskRequested);
    on<UndoTaskDeletion>(_undoTaskDeletion);
    on<RemoveTaskFromUI>(_removeTaskFromUI);
  }

  final HomeRemoteRepository _homeRemoteRepository;
  final DeleteTaskRemoteRepository _deleteTaskRemoteRepository;

  void _resetTaskRequested(
    ResetTaskRequested event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(task: null));
  }

  void _onFilterChanged(
    HomeFilterChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(selectedIndex: event.selectedIndex));

    /// Dynamically filter tasks based on the selected index
    switch (event.selectedIndex) {
      case 0:

        /// The `removeTaskFromUiIsInProgress` boolean variable is used to check if the user is attempting to delete a task.
        /// This ensures that we do not emit the tasks to fetch all tasks from the state during this process.
        ///
        /// The reason for this logic is that when the user presses the delete button on a task in the home screen's list view,
        /// a snack bar with an undo action is displayed for 6 seconds, allowing the user to cancel the deletion.
        /// If the user refreshes the screen while the task deletion is in progress (i.e., while the snack bar is still visible),
        /// triggering the `_onFilterChanged` event can cause an unusual behavior.
        ///
        /// Specifically, if the user attempts to delete a task and quickly refreshes the screen, then cancels the deletion,
        /// the task they tried to delete may appear twice in the home screen list view.
        /// To restore normal behavior, the user would need to refresh the screen again.
        ///
        /// To avoid this issue, the `removeTaskFromUiIsInProgress` variable is used to determine if a task deletion is ongoing.
        /// If a deletion is in progress, we do not emit the tasks to fetch all tasks from the state until the deletion process is complete
        /// or the user cancels the deletion.
        ///
        /// If the user cancels the deletion, the `removeTaskFromUiIsInProgress` variable is set to `false`,
        /// allowing the normal refresh logic to resume if the user wants to refresh the screen.
        /// Similarly, if the task is successfully deleted, the `removeTaskFromUiIsInProgress` variable is also set to `false`.

        final isDeletionTaskInProgress = state.removeTaskFromUiIsInProgress;
        if (isDeletionTaskInProgress) {
          return;
        }

        /// here we are get all task types
        emit(state.copyWith(tasks: state.allTasks));
        break;
      case 1:

        /// here we are get in progress task types
        emit(state.copyWith(tasks: state.inProgressTasks));
        break;
      case 2:

        /// here we are get waiting task types
        emit(state.copyWith(tasks: state.waitingTasks));
        break;
      case 3:

        /// here we are get finished task types
        emit(state.copyWith(tasks: state.finishedTasks));
        break;
      default:
        emit(state.copyWith(tasks: []));
    }
  }

  /// this is event for get all tasks from the server
  /// and filter them based on their status
  Future<void> _onAllTasksRequested(
    AllTasksRequested event,
    Emitter<HomeState> emit,
  ) async {
    /// The `removeTaskFromUiIsInProgress` boolean variable is used to check if the user is attempting to delete a task.
    /// for full explanation check the `_onFilterChanged` method in case 0 above :).
    final isDeletionTaskInProgress = state.removeTaskFromUiIsInProgress;
    if (isDeletionTaskInProgress) {
      return;
    }
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      List<TaskModel>? allTasks;
      final todos = await _homeRemoteRepository.getTasks(1);
      todos.fold(
        (failure) => emit(state.copyWith(
          status: HomeStatus.failure,
          message: failure.message,
        )),
        (tasks) {
          allTasks = tasks;
          emit(state.copyWith(
            status: HomeStatus.success,
            allTasks: tasks,
          ));
        },
      );

      /// here we are filtering the tasks based on their status
      final inProgressTasks =
          allTasks?.where((task) => task.status == "inprogress").toList();
      final waitingTasks =
          allTasks?.where((task) => task.status == "waiting").toList();
      final finishedTasks =
          allTasks?.where((task) => task.status == "finished").toList();

      emit(state.copyWith(
        status: HomeStatus.success,
        allTasks: allTasks,
        inProgressTasks: inProgressTasks,
        waitingTasks: waitingTasks,
        finishedTasks: finishedTasks,
        tasks: allTasks,
      ));
    } catch (error) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }

  /// this event for get specific task by id
  /// after scanning the qr code
  void _getTaskById(
    GetTaskById event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final task = await _homeRemoteRepository.getSpecificTask(event.id);
    task.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        message: failure.message,
      )),
      (task) {
        emit(state.copyWith(
          status: HomeStatus.success,
          task: task,
        ));
      },
    );
  }

  /// this event for remove task from the ui for short time 6 seconds
  void _removeTaskFromUI(event, emit) {
    emit(state.copyWith(removeTaskFromUiIsInProgress: true));
    final updatedTasks =
        state.tasks.where((task) => task.id != event.taskId).toList();
    emit(state.copyWith(tasks: updatedTasks));
  }

  /// this event for undo task deletion
  void _undoTaskDeletion(event, emit) {
    final updatedTasks = List.of(state.tasks);

    /// Reinsert the task at the original index
    updatedTasks.insert(
      event.index,
      event.task,
    );
    emit(
      state.copyWith(
        tasks: updatedTasks,
        removeTaskFromUiIsInProgress: false,
      ),
    );
  }

  /// this event for delete task by id permanently
  void _deleteTaskRequested(
    DeleteTaskRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      status: HomeStatus.loading,
      removeTaskFromUiIsInProgress: false,
    ));
    final result =
        await _deleteTaskRemoteRepository.deleteTask(taskId: event.taskId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: HomeStatus.failure,
        message: failure.message,
      )),
      (success) {
        emit(state.copyWith(
          status: HomeStatus.deleteSuccess,
          message: 'Task deleted successfully',
        ));
      },
    );
  }
}
