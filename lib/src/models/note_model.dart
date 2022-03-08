import 'package:hive/hive.dart';

import 'timedetail_model.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title;
  @HiveField(1)
  String desc;
  @HiveField(2)
  List<String> tags;
  @HiveField(3)
  TimeDetail timeDetail;
  Note(this.title, this.desc, this.tags, this.timeDetail);
}
