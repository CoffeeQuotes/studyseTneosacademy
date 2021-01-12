// To parse this JSON data, do
//
//     final courses = coursesFromJson(jsonString);

import 'dart:convert';

List<Courses> coursesFromJson(String str) => List<Courses>.from(json.decode(str).map((x) => Courses.fromJson(x)));

String coursesToJson(List<Courses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Courses {
  Courses({
    this.id,
    this.courseTitle,
    this.courseDesc,
    this.courseCode,
    this.courseProvider,
    this.courseInstance,
    this.instanceName,
    this.instanceDesc,
    this.courseMode,
    this.image,
    this.courseStatus,
    this.courseAttendanceMode,
    this.startDate,
    this.endDate,
    this.courseOrganizerName,
    this.courseOrganizerUrl,
    this.locationName,
    this.locationAddress,
    this.price,
    this.ratings,
    this.offerValidFrom,
    this.offerAvailability,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String courseTitle;
  String courseDesc;
  String courseCode;
  String courseProvider;
  String courseInstance;
  String instanceName;
  String instanceDesc;
  String courseMode;
  String image;
  String courseStatus;
  String courseAttendanceMode;
  DateTime startDate;
  DateTime endDate;
  String courseOrganizerName;
  String courseOrganizerUrl;
  String locationName;
  String locationAddress;
  String price;
  int ratings;
  DateTime offerValidFrom;
  int offerAvailability;
  DateTime createdAt;
  DateTime updatedAt;

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
    id: json["id"],
    courseTitle: json["course_title"],
    courseDesc: json["course_desc"],
    courseCode: json["course_code"],
    courseProvider: json["course_provider"],
    courseInstance: json["course_instance"],
    instanceName: json["instance_name"],
    instanceDesc: json["instance_desc"],
    courseMode: json["course_mode"],
    image: json["image"],
    courseStatus: json["course_status"],
    courseAttendanceMode: json["course_attendance_mode"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    courseOrganizerName: json["course_organizer_name"],
    courseOrganizerUrl: json["course_organizer_url"],
    locationName: json["location_name"],
    locationAddress: json["location_address"],
    price: json["price"],
    ratings: json["ratings"],
    offerValidFrom: DateTime.parse(json["offer_valid_from"]),
    offerAvailability: json["offer_availability"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_title": courseTitle,
    "course_desc": courseDesc,
    "course_code": courseCode,
    "course_provider": courseProvider,
    "course_instance": courseInstance,
    "instance_name": instanceName,
    "instance_desc": instanceDesc,
    "course_mode": courseMode,
    "image": image,
    "course_status": courseStatus,
    "course_attendance_mode": courseAttendanceMode,
    "start_date": startDate.toIso8601String().trimRight(),
    "end_date": endDate.toIso8601String(),
    "course_organizer_name": courseOrganizerName,
    "course_organizer_url": courseOrganizerUrl,
    "location_name": locationName,
    "location_address": locationAddress,
    "price": price,
    "ratings": ratings,
    "offer_valid_from": offerValidFrom.toIso8601String(),
    "offer_availability": offerAvailability,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
