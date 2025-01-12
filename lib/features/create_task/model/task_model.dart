import 'package:intl/intl.dart';

class TaskModel {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String userId;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  TaskModel({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.userId,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Factory method to create an instance from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      image: json['image'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      priority: json['priority'] as String,
      status: json['status'] as String,
      userId: json['user'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: json['__v'] as int,
    );
  }

  String getFormattedCreatedAt() {
    return DateFormat('dd/MM/yyyy').format(createdAt);
  }

  String getFormattedUpdatedAt() {
    return DateFormat('dd/MM/yyyy').format(updatedAt);
  }

  // Method to convert the model instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'desc': desc,
      'priority': priority,
      'status': status,
      'user': userId,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}