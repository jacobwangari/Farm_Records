import 'package:hive/hive.dart';

part 'models.g.dart';

// Layers model

@HiveType(typeId: 0)
class Layers extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String breed;

  @HiveField(3)
  int age;

  static int _counter = 0; // static counter variable

  Layers({
    required this.name,
    required this.age,
    required this.breed,
  }) : id = ++_counter; // auto-increment id
}

//Feeding layers

@HiveType(typeId: 1)
class FeedingLayers extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  double cost;

  @HiveField(3)
  DateTime date;

  FeedingLayers(
      {required this.id,
      required this.amount,
      required this.cost,
      required this.date});
}

//Layers Health

@HiveType(typeId: 2)
class LayersHealth extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double cost;

  @HiveField(3)
  DateTime date;

  LayersHealth(
      {required this.id,
      required this.name,
      required this.cost,
      required this.date});
}

// Hatching records

@HiveType(typeId: 3)
class Hatching extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int number;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  double earnings;

  Hatching(
      {required this.id,
      required this.number,
      required this.date,
      required this.earnings});
}

// Dairy model

@HiveType(typeId: 4)
class Dairy extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String breed;

  @HiveField(3)
  int age;
  
  static int _counter = 0; // static counter variable

  Dairy({
    required this.name,
    required this.age,
    required this.breed,
  }) : id = ++_counter; // auto-increment id
}

//Feeding Dairy

@HiveType(typeId: 5)
class FeedingDairy extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  double cost;

  @HiveField(3)
  DateTime date;

  FeedingDairy(
      {required this.id,
      required this.amount,
      required this.cost,
      required this.date});
}

//Dairy Health

@HiveType(typeId: 6)
class DairyHealth extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double cost;

  @HiveField(3)
  DateTime date;

  DairyHealth(
      {required this.id,
      required this.name,
      required this.cost,
      required this.date});
}

// Milking records

@HiveType(typeId: 7)
class Milking extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  double amount;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  double earnings;

  Milking(
      {required this.id,
      required this.amount,
      required this.date,
      required this.earnings});
}
