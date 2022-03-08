// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timedetail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeDetailAdapter extends TypeAdapter<TimeDetail> {
  @override
  final int typeId = 1;

  @override
  TimeDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeDetail(
      fields[0] as DateTime,
      fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TimeDetail obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
