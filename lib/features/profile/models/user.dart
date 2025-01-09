import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String displayName;
  final String username;
  final List<String> roles;
  final bool active;
  final int experienceYears;
  final String address;
  final String level;
  final String createdAt;
  final String updatedAt;
  final int v;

  const UserModel({
    required this.id,
    required this.displayName,
    required this.username,
    required this.roles,
    required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      displayName: map['displayName'] as String,
      username: map['username'] as String,
      roles: List<String>.from(map['roles']),
      active: map['active'] as bool,
      experienceYears: map['experienceYears'] as int,
      address: map['address'] as String,
      level: map['level'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      v: map['__v'] as int,
    );
  }

  UserModel copyWith({
    String? id,
    String? displayName,
    String? username,
    List<String>? roles,
    bool? active,
    int? experienceYears,
    String? address,
    String? level,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return UserModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      roles: roles ?? this.roles,
      active: active ?? this.active,
      experienceYears: experienceYears ?? this.experienceYears,
      address: address ?? this.address,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  List<Object?> get props => [
        id,
        displayName,
        username,
        roles,
        active,
        experienceYears,
        address,
        level,
        createdAt,
        updatedAt,
        v,
      ];
}
