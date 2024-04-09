import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completed_note_model.g.dart';

@JsonSerializable()
class CompletedNoteModel extends Equatable {
  final String? note;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CompletedNoteModel({this.note, this.statusCode});

  factory CompletedNoteModel.fromJson(Map<String, dynamic> json) {
    return _$CompletedNoteModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CompletedNoteModelToJson(this);

  CompletedNoteModel copyWith({
    String? note,
    String? statusCode,
  }) {
    return CompletedNoteModel(
      note: note ?? this.note,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [note, statusCode];
}
