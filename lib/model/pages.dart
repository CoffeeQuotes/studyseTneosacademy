// To parse this JSON data, do
//
//     final pages = pagesFromJson(jsonString);

import 'dart:convert';

List<Pages> pagesFromJson(String str) => List<Pages>.from(json.decode(str).map((x) => Pages.fromJson(x)));

String pagesToJson(List<Pages> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pages {
  Pages({
    this.id,
    this.authorId,
    this.title,
    this.excerpt,
    this.body,
    this.image,
    this.slug,
    this.metaDescription,
    this.metaKeywords,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int authorId;
  String title;
  String excerpt;
  String body;
  String image;
  String slug;
  String metaDescription;
  String metaKeywords;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    id: json["id"],
    authorId: json["author_id"],
    title: json["title"],
    excerpt: json["excerpt"],
    body: json["body"],
    image: json["image"],
    slug: json["slug"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author_id": authorId,
    "title": title,
    "excerpt": excerpt,
    "body": body,
    "image": image,
    "slug": slug,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
