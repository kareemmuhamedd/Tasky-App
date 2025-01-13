import 'package:hive_flutter/hive_flutter.dart';

import '../../create_task/model/task_model.dart';

abstract interface class TaskLocalDataSource {
  Future<void> uploadLocalTasks({required List<TaskModel> tasks});

  Future<List<TaskModel>> loadTasks();
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static const String _boxName = 'tasks';

  /// Open the Hive box, perform the action, and close it.
  Future<void> _withBox(
    Future<void> Function(Box<TaskModel> box) action,
  ) async {
    final box = await Hive.openBox<TaskModel>(_boxName);
    try {
      await action(box);
    } finally {
      await box.close();
    }
  }

  /// Open the Hive box, perform the action, and close it, returning a result.
  Future<T> _withBoxResult<T>(
    Future<T> Function(Box<TaskModel> box) action,
  ) async {
    final box = await Hive.openBox<TaskModel>(_boxName);
    try {
      return await action(box);
    } finally {
      await box.close();
    }
  }

  @override
  Future<List<TaskModel>> loadTasks() async {
    print('Loading tasks...');
    return _withBoxResult((box) async {
      final tasks = <TaskModel>[];
      for (var key in box.keys) {
        final task = box.get(key);
        if (task != null) {
          tasks.add(task);
        }
      }
      return tasks;
    });
  }

  @override
  Future<void> uploadLocalTasks({required List<TaskModel> tasks}) async {
    await _withBox((box) async {
      await box.clear();
      for (int i = 0; i < tasks.length; i++) {
        await box.put('task_$i', tasks[i]);
      }
    });
  }
}
