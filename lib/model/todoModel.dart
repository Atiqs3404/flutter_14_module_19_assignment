import 'dart:convert';

class TodoModel {
  String id;
  String title;
  String description;
  DateTime createdDate;
  int v;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.v,
  });

  factory TodoModel.fromRawJson(String str) =>
      TodoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    createdDate: DateTime.parse(json["created_date"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "created_date": createdDate.toIso8601String(),
    "__v": v,
  };
}
