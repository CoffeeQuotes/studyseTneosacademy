// To parse this JSON data, do
//
//     final advertisements = advertisementsFromJson(jsonString);

import 'dart:convert';

List<Advertisements> advertisementsFromJson(String str) => List<Advertisements>.from(json.decode(str).map((x) => Advertisements.fromJson(x)));

String advertisementsToJson(List<Advertisements> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Advertisements {
  Advertisements({
    this.id,
    this.primaryImage,
    this.secondaryImage,
    this.thirdImage,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.body,
  });

  int id;
  String primaryImage;
  String secondaryImage;
  String thirdImage;
  DateTime createdAt;
  DateTime updatedAt;
  String title;
  String body;

  factory Advertisements.fromJson(Map<String, dynamic> json) => Advertisements(
    id: json["id"],
    primaryImage: json["primary_image"],
    secondaryImage: json["secondary_image"] == null ? null : json["secondary_image"],
    thirdImage: json["third_image"] == null ? null : json["third_image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "primary_image": primaryImage,
    "secondary_image": secondaryImage == null ? null : secondaryImage,
    "third_image": thirdImage == null ? null : thirdImage,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "title": title,
    "body": body,
  };
}
