part of 'create_task_bloc.dart';

enum CreateTaskStatus {
  initial,
  loading,
  success,
  error,
}

class CreateTaskState extends Equatable {
  const CreateTaskState._({
    required this.status,
    required this.message,
    this.selectedPriority,
    this.selectedDueDate,
  });

  const CreateTaskState.initial()
      : this._(
    status: CreateTaskStatus.initial,
    message: '',
  );

  final CreateTaskStatus status;
  final String message;
  final String? selectedPriority;
  final String? selectedDueDate;

  CreateTaskState copyWith({
    CreateTaskStatus? status,
    String? message,
    String? selectedPriority,
    String? selectedDueDate,
  }) {
    return CreateTaskState._(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedDueDate: selectedDueDate ?? this.selectedDueDate,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    selectedPriority,
    selectedDueDate,
  ];
}
