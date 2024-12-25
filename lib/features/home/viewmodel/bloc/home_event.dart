part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeFilterChanged extends HomeEvent {
  final int selectedIndex;

  const HomeFilterChanged(this.selectedIndex);
}

final class AllTasksRequested extends HomeEvent {
  const AllTasksRequested();
}

final class InProgressTasksRequested extends HomeEvent {
  const InProgressTasksRequested();
}

final class WaitingTasksRequested extends HomeEvent {
  const WaitingTasksRequested();
}

final class FinishedTasksRequested extends HomeEvent {
  const FinishedTasksRequested();
}
