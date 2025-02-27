// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileEntityAdapter extends TypeAdapter<FileEntity> {
  @override
  final int typeId = 0;

  @override
  FileEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileEntity(
      id: fields[0] as String,
      name: fields[1] as String,
      url: fields[2] as String,
      type: fields[3] as String,
      downloadUrl: fields[5] as String,
      isDownloaded: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FileEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isDownloaded)
      ..writeByte(5)
      ..write(obj.downloadUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
