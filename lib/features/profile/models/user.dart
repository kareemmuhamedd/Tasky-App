import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'user.g.dart';
@HiveType(typeId: 1)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String displayName;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final List<String> roles;
  @HiveField(4)
  final bool active;
  @HiveField(5)
  final int experienceYears;
  @HiveField(6)
  final String address;
  @HiveField(7)
  final String level;
  @HiveField(8)
  final String createdAt;
  @HiveField(9)
  final String updatedAt;
  @HiveField(10)
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

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'displayName': displayName,
      'username': username,
      'roles': roles,
      'active': active,
      'experienceYears': experienceYears,
      'address': address,
      'level': level,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
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
