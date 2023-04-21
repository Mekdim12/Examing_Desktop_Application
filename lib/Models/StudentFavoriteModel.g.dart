// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudentFavoriteModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentFavoriteTypeModelAdapter
    extends TypeAdapter<StudentFavoriteTypeModel> {
  @override
  final int typeId = 3;

  @override
  StudentFavoriteTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentFavoriteTypeModel(
      (fields[0] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudentFavoriteTypeModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.studentFav);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentFavoriteTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
