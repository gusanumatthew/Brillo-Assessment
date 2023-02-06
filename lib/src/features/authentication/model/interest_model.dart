import 'package:hive_flutter/hive_flutter.dart';

part 'interest_model.g.dart';

@HiveType(typeId: 0)
class Interest {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Interest(this.id, this.name);
}

final interests = [
  Interest(1, 'Football'),
  Interest(2, 'Basketball'),
  Interest(3, 'Ice Hockey'),
  Interest(4, 'Motorsports'),
  Interest(5, 'Bandy'),
  Interest(6, 'Rugby'),
  Interest(7, 'Skiing'),
  Interest(8, 'Shooting'),
];
