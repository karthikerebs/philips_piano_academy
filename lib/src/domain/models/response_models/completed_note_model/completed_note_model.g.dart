// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completed_note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletedNoteModel _$CompletedNoteModelFromJson(Map<String, dynamic> json) =>
    CompletedNoteModel(
      note: json['note'] as String?,
      statusCode: json['status_code'] as String?,
    );

Map<String, dynamic> _$CompletedNoteModelToJson(CompletedNoteModel instance) =>
    <String, dynamic>{
      'note': instance.note,
      'status_code': instance.statusCode,
    };
