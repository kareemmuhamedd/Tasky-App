part of 'update_task_bloc.dart';

enum UpdateTaskStatus {
  initial,
  loading,
  success,
  error,
}

class UpdateTaskState extends Equatable {
  const UpdateTaskState._({
    required this.status,
    required this.message,
    this.selectedPriority,
    this.selectedProgressStatus,
    this.image,
    this.title,
    this.description,
  });

  const UpdateTaskState.initial()
      : this._(
          status: UpdateTaskStatus.initial,
          message: '',
        );

  final UpdateTaskStatus status;
  final String message;
  final String? selectedPriority;
  final String? selectedProgressStatus;
  final String? image;
  final String? title;
  final String? description;

  UpdateTaskState copyWith({
    UpdateTaskStatus? status,
    String? message,
    String? selectedPriority,
    String? selectedProgressStatus,
    String? image,
    String? title,
    String? description,
  }) {
    return UpdateTaskState._(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedProgressStatus:
          selectedProgressStatus ?? this.selectedProgressStatus,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        selectedPriority,
        selectedProgressStatus,
        image,
      ];
}
