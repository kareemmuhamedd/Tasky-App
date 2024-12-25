import 'package:bloc/bloc.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial()) {
    on<HomeFilterChanged>(_onFilterChanged);
    on<AllTasksRequested>(_onAllTasksRequested);
  }

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
      AllTasksRequested event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate loading

      // Example data (replace this with real data)
      List<TaskModel> allTasks = _getAllTasks();

      // Filter tasks by status and update the state
      final inProgressTasks = allTasks.where((task) => task.status == "in-progress").toList();
      final waitingTasks = allTasks.where((task) => task.status == "waiting").toList();
      final finishedTasks = allTasks.where((task) => task.status == "finished").toList();

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

  // Helper method to fetch all tasks
  List<TaskModel> _getAllTasks() {
    // Example data - replace with real data fetching logic
    return fakeTasks;
  }
}
