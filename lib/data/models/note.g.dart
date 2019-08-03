// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
      title: json['title'] as String,
      description: json['description'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String));
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'date': instance.date?.toIso8601String()
    };
