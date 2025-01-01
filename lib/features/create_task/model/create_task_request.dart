import 'package:flutter/foundation.dart';

class CreateTaskRequest {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String dueDate;

  CreateTaskRequest({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate,
  });

  factory CreateTaskRequest.fromJson(Map<String, dynamic> json) {
    return CreateTaskRequest(
      image: json['image'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      priority: json['priority'] as String,
      dueDate: json['dueDate'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'desc': desc,
      'priority': priority,
      'dueDate': dueDate,
    };
  }

  CreateTaskRequest copyWith({
    String? image,
    String? title,
    String? desc,
    String? priority,
    String? dueDate,
  }) {
    return CreateTaskRequest(
      image: image ?? this.image,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
