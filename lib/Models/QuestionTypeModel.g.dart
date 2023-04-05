// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionTypeModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionTypeModelAdapter extends TypeAdapter<QuestionTypeModel> {
  @override
  final int typeId = 2;

  @override
  QuestionTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionTypeModel(
      (fields[0] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuestionTypeModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.question_type_items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
