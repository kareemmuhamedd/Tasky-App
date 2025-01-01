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
    this.image,
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
  final String? image;

  CreateTaskState copyWith({
    CreateTaskStatus? status,
    String? message,
    String? selectedPriority,
    String? selectedDueDate,
    String? image,
  }) {
    return CreateTaskState._(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedDueDate: selectedDueDate ?? this.selectedDueDate,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        selectedPriority,
        selectedDueDate,
        image,
      ];
}
