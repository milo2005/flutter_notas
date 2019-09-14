import 'package:json_annotation/json_annotation.dart';

part 'user_task.g.dart';

@JsonSerializable(nullable: true)
class UserTask{

  String title, description;
  DateTime date;
  String id;


  UserTask({this.id, this.title, this.description, this.date});

  Map<String, dynamic> toJson() => _$UserTaskToJson(this);
  factory UserTask.fromJson(String id, Map<String, dynamic> json){
    final obj = _$UserTaskFromJson(json);
    obj.id = id;
    return obj;
  }



}