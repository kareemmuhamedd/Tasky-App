import 'package:tasky_app/features/profile/models/user.dart';

class UpdateTaskRequest {
  final String? image;
  final String? title;
  final String? desc;
  final String? priority;
  final String? status;
  final UserModel? user;

  UpdateTaskRequest({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (image != null) data['image'] = image;
    if (title != null) data['title'] = title;
    if (desc != null) data['desc'] = desc;
    if (priority != null) data['priority'] = priority;
    if (status != null) data['status'] = status;
    if (user != null) data['user'] = user;

    return data;
  }

  UpdateTaskRequest copyWith({
    String? image,
    String? title,
    String? desc,
    String? priority,
    String? status,
    UserModel? user,
  }) {
    return UpdateTaskRequest(
      image: image ?? this.image,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
