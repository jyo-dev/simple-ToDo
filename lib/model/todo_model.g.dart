// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  final int typeId = 0;

  @override
  ToDo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDo()
      ..task = fields[0] as String
      ..date = fields[1] as String
      ..priority = fields[2] as int
      ..status = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.priority)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
