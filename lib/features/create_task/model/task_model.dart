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

List<TaskModel> fakeTasks = [
  TaskModel(
    image: "path1.png",
    title: "Task 1",
    desc: "Description for Task 1",
    priority: "high",
    status: "waiting",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906bf",
    createdAt: DateTime.parse("2024-12-23T22:34:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:34:17.729Z"),
    version: 0,
  ),
  TaskModel(
    image: "path2.png",
    title: "Task 2",
    desc: "Description for Task 2",
    priority: "medium",
    status: "in-progress",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c0",
    createdAt: DateTime.parse("2024-12-23T22:35:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:35:17.729Z"),
    version: 1,
  ),
  TaskModel(
    image: "path3.png",
    title: "Task 3",
    desc: "Description for Task 3",
    priority: "high",
    status: "finished",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c1",
    createdAt: DateTime.parse("2024-12-23T22:36:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:36:17.729Z"),
    version: 2,
  ),
  TaskModel(
    image: "path4.png",
    title: "Task 4",
    desc: "Description for Task 4",
    priority: "low",
    status: "waiting",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c2",
    createdAt: DateTime.parse("2024-12-23T22:37:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:37:17.729Z"),
    version: 3,
  ),
  TaskModel(
    image: "path5.png",
    title: "Task 5",
    desc: "Description for Task 5",
    priority: "medium",
    status: "in-progress",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c3",
    createdAt: DateTime.parse("2024-12-23T22:38:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:38:17.729Z"),
    version: 4,
  ),
  TaskModel(
    image: "path6.png",
    title: "Task 6",
    desc: "Description for Task 6",
    priority: "high",
    status: "finished",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c4",
    createdAt: DateTime.parse("2024-12-23T22:39:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:39:17.729Z"),
    version: 5,
  ),
  TaskModel(
    image: "path7.png",
    title: "Task 7",
    desc: "Description for Task 7",
    priority: "low",
    status: "waiting",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c5",
    createdAt: DateTime.parse("2024-12-23T22:40:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:40:17.729Z"),
    version: 6,
  ),
  TaskModel(
    image: "path8.png",
    title: "Task 8",
    desc: "Description for Task 8",
    priority: "medium",
    status: "in-progress",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c6",
    createdAt: DateTime.parse("2024-12-23T22:41:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:41:17.729Z"),
    version: 7,
  ),
  TaskModel(
    image: "path9.png",
    title: "Task 9",
    desc: "Description for Task 9",
    priority: "high",
    status: "finished",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c7",
    createdAt: DateTime.parse("2024-12-23T22:42:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:42:17.729Z"),
    version: 8,
  ),
  TaskModel(
    image: "path10.png",
    title: "Task 10",
    desc: "Description for Task 10",
    priority: "low",
    status: "waiting",
    userId: "6767563fbe4d2c1bfe68f44a",
    id: "6769e569be4d2c1bfe6906c8",
    createdAt: DateTime.parse("2024-12-23T22:43:17.729Z"),
    updatedAt: DateTime.parse("2024-12-23T22:43:17.729Z"),
    version: 9,
  ),
];
