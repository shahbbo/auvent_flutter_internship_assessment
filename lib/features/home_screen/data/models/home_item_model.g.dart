// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeItemModelAdapter extends TypeAdapter<HomeItemModel> {
  @override
  final int typeId = 0;

  @override
  HomeItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeItemModel(
      id: fields[0] as String,
      image: fields[1] as String,
      name: fields[2] as String,
      overlayText: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.overlayText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
