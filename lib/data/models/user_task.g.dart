// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTask _$UserTaskFromJson(Map<String, dynamic> json) {
  return UserTask(
    title: json['title'] as String,
    description: json['description'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$UserTaskToJson(UserTask instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'date': instance.date?.toIso8601String(),
    };
