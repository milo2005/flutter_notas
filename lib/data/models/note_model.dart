import 'package:json_annotation/json_annotation.dart';

// flutter pub run build_runner build

part 'note_model.g.dart';

@JsonSerializable(nullable: true)
class Note{

  String id;
  String title, description;
  DateTime date;

  Note({this.id, this.title, this.description, this.date});

  Map<String, dynamic> toJson() => _$NoteToJson(this);
  factory Note.fromJson(String id, Map<String, dynamic> json){
    final note =_$NoteFromJson(json);
    note.id = id;
    return note;
  }

}