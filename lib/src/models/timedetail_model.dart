import 'package:hive/hive.dart';

part 'timedetail_model.g.dart';

@HiveType(typeId: 1)
class TimeDetail {
  @HiveField(0)
  DateTime createdAt;
  @HiveField(1)
  DateTime updatedAt;

  TimeDetail(this.createdAt, this.updatedAt);
}
