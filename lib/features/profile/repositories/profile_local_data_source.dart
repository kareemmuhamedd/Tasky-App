import 'package:hive/hive.dart';
import '../models/user.dart';

abstract interface class ProfileLocalDataSource {
  void uploadLocalProfile({
    required UserModel profile,
  });

  UserModel?
      loadProfile(); // Changed to return `UserModel?` to handle nulls safely
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Box box;

  ProfileLocalDataSourceImpl(this.box);

  @override
  UserModel? loadProfile() {
    // Fetch the profile JSON from Hive
    final profileJson = box.get('profile');
    if (profileJson != null) {
      // Parse the JSON into a UserModel
      return UserModel.fromJson(profileJson);
    }
    // Return null if no profile is found
    return null;
  }

  @override
  void uploadLocalProfile({required UserModel profile}) {
    // Save the profile as JSON in Hive
    box.put('profile', profile.toJson());
  }
}
