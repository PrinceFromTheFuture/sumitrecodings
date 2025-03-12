// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MeetingHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeetingHiveAdapter extends TypeAdapter<MeetingHive> {
  @override
  final int typeId = 0;

  @override
  MeetingHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeetingHive(
      title: fields[0] as String,
      date: fields[1] as DateTime,
      name: fields[2] as String,
      meetingId: fields[3] as String,
      location: fields[4] as String,
      startTimeHour: fields[5] as int,
      endTimeHour: fields[6] as int,
      endTimeMinute: fields[14] as int,
      startTimeMinute: fields[13] as int,
      isFirstMeetingAtClient: fields[7] as bool,
      distance: fields[8] as double,
      expectedPayment: fields[9] as double,
      isReported: fields[10] as bool,
      notes: fields[11] as String,
      isDeleteed: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MeetingHive obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.meetingId)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.startTimeHour)
      ..writeByte(6)
      ..write(obj.endTimeHour)
      ..writeByte(7)
      ..write(obj.isFirstMeetingAtClient)
      ..writeByte(8)
      ..write(obj.distance)
      ..writeByte(9)
      ..write(obj.expectedPayment)
      ..writeByte(10)
      ..write(obj.isReported)
      ..writeByte(11)
      ..write(obj.notes)
      ..writeByte(12)
      ..write(obj.isDeleteed)
      ..writeByte(13)
      ..write(obj.startTimeMinute)
      ..writeByte(14)
      ..write(obj.endTimeMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeetingHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
