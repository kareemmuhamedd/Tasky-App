import 'package:hive_flutter/hive_flutter.dart';

import '../models/user.dart';

abstract interface class ProfileLocalDataSource {
  Future<void> uploadLocalProfile({
    required UserModel profile,
  });

  Future<UserModel?> loadProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _boxName = 'profile';

  /// Open the Hive box, perform the action, and close it.
  Future<void> _withBox(
    Future<void> Function(Box<UserModel> box) action,
  ) async {
    final box = await Hive.openBox<UserModel>(_boxName);
    try {
      await action(box);
    } finally {
      await box.close();
    }
  }

  /// Open the Hive box, perform the action, and close it, returning a result.
  Future<T> _withBoxResult<T>(
    Future<T> Function(Box<UserModel> box) action,
  ) async {
    final box = await Hive.openBox<UserModel>(_boxName);
    try {
      return await action(box);
    } finally {
      await box.close();
    }
  }

  @override
  Future<void> uploadLocalProfile({required UserModel profile}) async {
    await _withBox((box) async {
      await box.clear(); // Clear any existing profile data.
      await box.put('user_profile', profile);
    });
  }

  @override
  Future<UserModel?> loadProfile() async {
    return _withBoxResult((box) async {
      final profile = box.get('user_profile');
      return profile;
    });
  }
}
