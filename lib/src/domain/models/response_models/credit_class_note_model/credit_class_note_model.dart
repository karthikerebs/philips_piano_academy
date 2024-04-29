import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_class_note_model.g.dart';

@JsonSerializable()
class CreditClassNoteModel extends Equatable {
  final String? note;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const CreditClassNoteModel({this.note, this.statusCode});

  factory CreditClassNoteModel.fromJson(Map<String, dynamic> json) {
    return _$CreditClassNoteModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreditClassNoteModelToJson(this);

  CreditClassNoteModel copyWith({
    String? note,
    String? statusCode,
  }) {
    return CreditClassNoteModel(
      note: note ?? this.note,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [note, statusCode];
}
