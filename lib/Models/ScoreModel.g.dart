// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScoreModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentScoreModelAdapter extends TypeAdapter<StudentScoreModel> {
  @override
  final int typeId = 4;

  @override
  StudentScoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentScoreModel(
      (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<dynamic>())),
    );
  }

  @override
  void write(BinaryWriter writer, StudentScoreModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.studentScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentScoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
