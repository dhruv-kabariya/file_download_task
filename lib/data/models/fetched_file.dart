import 'dart:convert';

class FecthedFile {
  final String image;
  final String by;
  final String description;
  final String download;
  final bool watermark;
  final String source;
  final List<String> diffrentSizes;
  final String color;
  final String rawImage;
  final int rawImageWidth;
  final int rawImageHeight;
  final String id;

  FecthedFile({
    required this.image,
    required this.by,
    required this.description,
    required this.download,
    required this.watermark,
    required this.source,
    required this.diffrentSizes,
    required this.color,
    required this.rawImage,
    required this.rawImageWidth,
    required this.rawImageHeight,
    required this.id,
  });

  FecthedFile copyWith({
    String? image,
    String? by,
    String? description,
    String? download,
    bool? watermark,
    String? source,
    List<String>? diffrentSizes,
    String? color,
    String? rawImage,
    int? rawImageWidth,
    int? rawImageHeight,
    String? id,
  }) =>
      FecthedFile(
        image: image ?? this.image,
        by: by ?? this.by,
        description: description ?? this.description,
        download: download ?? this.download,
        watermark: watermark ?? this.watermark,
        source: source ?? this.source,
        diffrentSizes: diffrentSizes ?? this.diffrentSizes,
        color: color ?? this.color,
        rawImage: rawImage ?? this.rawImage,
        rawImageWidth: rawImageWidth ?? this.rawImageWidth,
        rawImageHeight: rawImageHeight ?? this.rawImageHeight,
        id: id ?? this.id,
      );

  factory FecthedFile.fromJson(String str) =>
      FecthedFile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FecthedFile.fromMap(Map<String, dynamic> json) => FecthedFile(
        image: json["image"] ?? '',
        by: json["by"] ?? '',
        description: json["description"] ?? '',
        download: json["download"] ?? '',
        watermark: json["watermark"] ?? false,
        source: json["source"] ?? "",
        diffrentSizes: List<String>.from(
          (json["diffrentSizes"] ?? '').map((x) => x),
        ),
        color: json["color"] ?? '',
        rawImage: json["rawImage"] ?? '',
        rawImageWidth: json["rawImageWidth"] ?? 0,
        rawImageHeight: json["rawImageHeight"] ?? 0,
        id: json["id"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "by": by,
        "description": description,
        "download": download,
        "watermark": watermark,
        "source": source,
        "diffrentSizes": List<dynamic>.from(diffrentSizes.map((x) => x)),
        "color": color,
        "rawImage": rawImage,
        "rawImageWidth": rawImageWidth,
        "rawImageHeight": rawImageHeight,
        "id": id,
      };
}
