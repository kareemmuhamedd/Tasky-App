import 'package:bloc/bloc.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/home/repositories/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(const HomeState.initial()) {
    on<HomeFilterChanged>(_onFilterChanged);
    on<AllTasksRequested>(_onAllTasksRequested);
  }

  final HomeRepository _homeRepository;

  void _onFilterChanged(HomeFilterChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedIndex: event.selectedIndex));

    // Dynamically filter tasks based on the selected index
    switch (event.selectedIndex) {
      case 0: // All tasks
        emit(state.copyWith(tasks: state.allTasks));
        break;
      case 1: // In-progress tasks
        emit(state.copyWith(tasks: state.inProgressTasks));
        break;
      case 2: // Waiting tasks
        emit(state.copyWith(tasks: state.waitingTasks));
        break;
      case 3: // Finished tasks
        emit(state.copyWith(tasks: state.finishedTasks));
        break;
      default:
        emit(state.copyWith(tasks: [])); // Fallback for unknown index
    }
  }

  Future<void> _onAllTasksRequested(
    AllTasksRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    print('i am trying to get tasks');
    try {
      print('i am trying to get tasks in try');
      List<TaskModel>? allTasks;
      final todos = await _homeRepository.getTasks(1);
      todos.fold(
        (failure) {
          print('i have failed to get tasks $failure');
          emit(state.copyWith(
          status: HomeStatus.failure,
          message: failure.message,
        ));
        },
        (tasks) {
          allTasks = tasks;
          print(allTasks?[0].desc);
          emit(state.copyWith(
            status: HomeStatus.success,
            allTasks: tasks,
          ));
        },
      );

      // Example data (replace this with real data)

      // Filter tasks by status and update the state
      final inProgressTasks =
          allTasks?.where((task) => task.status == "in-progress").toList();
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
        tasks: allTasks, // Initially display all tasks
      ));
    } catch (error) {
      emit(state.copyWith(
          status: HomeStatus.failure, message: error.toString()));
    }
  }
}
