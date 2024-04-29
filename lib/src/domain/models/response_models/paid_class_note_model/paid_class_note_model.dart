import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paid_class_note_model.g.dart';

@JsonSerializable()
class PaidClassNoteModel extends Equatable {
  final String? note;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const PaidClassNoteModel({this.note, this.statusCode});

  factory PaidClassNoteModel.fromJson(Map<String, dynamic> json) {
    return _$PaidClassNoteModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaidClassNoteModelToJson(this);

  PaidClassNoteModel copyWith({
    String? note,
    String? statusCode,
  }) {
    return PaidClassNoteModel(
      note: note ?? this.note,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [note, statusCode];
}
