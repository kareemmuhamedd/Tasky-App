part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeFilterChanged extends HomeEvent {
  final int selectedIndex;

  const HomeFilterChanged(this.selectedIndex);
}

final class AllTasksRequested extends HomeEvent {
  const AllTasksRequested();
}

final class GetTaskById extends HomeEvent {
  final String id;

  const GetTaskById(this.id);
}
final class ResetTaskRequested extends HomeEvent {
  const ResetTaskRequested();
}
