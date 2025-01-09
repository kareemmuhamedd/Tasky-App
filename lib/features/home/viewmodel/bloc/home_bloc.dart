import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/delete_task/repositories/delete_task_repository.dart';
import 'package:tasky_app/features/home/repositories/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
      {required HomeRemoteRepository homeRepository,
      required DeleteTaskRemoteRepository deleteTaskRemoteRepository})
      : _homeRepository = homeRepository,
        _deleteTaskRemoteRepository = deleteTaskRemoteRepository,
        super(const HomeState.initial()) {
    on<HomeFilterChanged>(_onFilterChanged);
    on<AllTasksRequested>(_onAllTasksRequested);
    on<GetTaskById>(_getTaskById);
    on<ResetTaskRequested>(_resetTaskRequested);
  }

  final HomeRemoteRepository _homeRepository;
  final DeleteTaskRemoteRepository _deleteTaskRemoteRepository;

  void _onFilterChanged(HomeFilterChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedIndex: event.selectedIndex));

    /// Dynamically filter tasks based on the selected index
    switch (event.selectedIndex) {
      case 0:

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
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      List<TaskModel>? allTasks;
      final todos = await _homeRepository.getTasks(1);
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
      emit(state.copyWith(
          status: HomeStatus.failure, message: error.toString()));
    }
  }

  /// this event for get specific task by id
  /// after scanning the qr code
  void _getTaskById(GetTaskById event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    final task = await _homeRepository.getSpecificTask(event.id);
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

  void _resetTaskRequested(ResetTaskRequested event, Emitter<HomeState> emit) {
    emit(state.copyWith(task: null));
  }
}
