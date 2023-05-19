// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LayersAdapter extends TypeAdapter<Layers> {
  @override
  final int typeId = 0;

  @override
  Layers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Layers(
      name: fields[1] as String,
      age: fields[3] as int,
      breed: fields[2] as String,
    )..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Layers obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.breed)
      ..writeByte(3)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FeedingLayersAdapter extends TypeAdapter<FeedingLayers> {
  @override
  final int typeId = 1;

  @override
  FeedingLayers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedingLayers(
      id: fields[0] as int,
      amount: fields[1] as double,
      cost: fields[2] as double,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FeedingLayers obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedingLayersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LayersHealthAdapter extends TypeAdapter<LayersHealth> {
  @override
  final int typeId = 2;

  @override
  LayersHealth read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LayersHealth(
      id: fields[0] as int,
      name: fields[1] as String,
      cost: fields[2] as double,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LayersHealth obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LayersHealthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HatchingAdapter extends TypeAdapter<Hatching> {
  @override
  final int typeId = 3;

  @override
  Hatching read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hatching(
      id: fields[0] as int,
      number: fields[1] as int,
      date: fields[2] as DateTime,
      earnings: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Hatching obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.earnings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HatchingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DairyAdapter extends TypeAdapter<Dairy> {
  @override
  final int typeId = 4;

  @override
  Dairy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dairy(
      name: fields[1] as String,
      age: fields[3] as int,
      breed: fields[2] as String,
    )..id = fields[0] as int;
  }

  @override
  void write(BinaryWriter writer, Dairy obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.breed)
      ..writeByte(3)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DairyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FeedingDairyAdapter extends TypeAdapter<FeedingDairy> {
  @override
  final int typeId = 5;

  @override
  FeedingDairy read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedingDairy(
      id: fields[0] as int,
      amount: fields[1] as double,
      cost: fields[2] as double,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FeedingDairy obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedingDairyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DairyHealthAdapter extends TypeAdapter<DairyHealth> {
  @override
  final int typeId = 6;

  @override
  DairyHealth read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DairyHealth(
      id: fields[0] as int,
      name: fields[1] as String,
      cost: fields[2] as double,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DairyHealth obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DairyHealthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MilkingAdapter extends TypeAdapter<Milking> {
  @override
  final int typeId = 7;

  @override
  Milking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Milking(
      id: fields[0] as int,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      earnings: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Milking obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.earnings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MilkingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
