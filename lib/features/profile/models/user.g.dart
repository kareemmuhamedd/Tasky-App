// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      displayName: fields[1] as String,
      username: fields[2] as String,
      roles: (fields[3] as List).cast<String>(),
      active: fields[4] as bool,
      experienceYears: fields[5] as int,
      address: fields[6] as String,
      level: fields[7] as String,
      createdAt: fields[8] as String,
      updatedAt: fields[9] as String,
      v: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.roles)
      ..writeByte(4)
      ..write(obj.active)
      ..writeByte(5)
      ..write(obj.experienceYears)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
