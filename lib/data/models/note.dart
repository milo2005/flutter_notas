import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(nullable: true)
class Note{

  String title;
  String description;
  DateTime date;

  Note({this.title, this.description, this.date});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);

}