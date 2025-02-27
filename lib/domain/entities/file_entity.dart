import 'package:hive/hive.dart';

part 'file_entity.g.dart';

@HiveType(typeId: 0)
class FileEntity extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String type;

  @HiveField(4)
  bool isDownloaded;

  @HiveField(5)
  final String downloadUrl;

  FileEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
    required this.downloadUrl,
    this.isDownloaded = false,
  });
}
