// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AccountHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountHiveAdapter extends TypeAdapter<AccountHive> {
  @override
  final int typeId = 1;

  @override
  AccountHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountHive(
      firstName: fields[1] as String,
      isFirstLogin: fields[0] as bool,
      lastName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isFirstLogin)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
