part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeState {
  const HomeState._({
    required this.status,
    required this.message,
    required this.selectedIndex,
    required this.tasks,
    required this.allTasks,
    required this.inProgressTasks,
    required this.waitingTasks,
    required this.finishedTasks,
  });

  const HomeState.initial()
      : this._(
    status: HomeStatus.initial,
    message: '',
    selectedIndex: 0,
    tasks: const [],
    allTasks: const [],
    inProgressTasks: const [],
    waitingTasks: const [],
    finishedTasks: const [],
  );

  final HomeStatus status;
  final String message;
  final int selectedIndex;
  final List<TaskModel> tasks;
  final List<TaskModel> allTasks;
  final List<TaskModel> inProgressTasks;
  final List<TaskModel> waitingTasks;
  final List<TaskModel> finishedTasks;

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    int? selectedIndex,
    List<TaskModel>? tasks,
    List<TaskModel>? allTasks,
    List<TaskModel>? inProgressTasks,
    List<TaskModel>? waitingTasks,
    List<TaskModel>? finishedTasks,
  }) {
    return HomeState._(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      tasks: tasks ?? this.tasks,
      allTasks: allTasks ?? this.allTasks,
      inProgressTasks: inProgressTasks ?? this.inProgressTasks,
      waitingTasks: waitingTasks ?? this.waitingTasks,
      finishedTasks: finishedTasks ?? this.finishedTasks,
    );
  }
}