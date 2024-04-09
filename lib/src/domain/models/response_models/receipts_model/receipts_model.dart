import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'receipt.dart';

part 'receipts_model.g.dart';

@JsonSerializable()
class ReceiptsModel extends Equatable {
  final List<Receipt>? receipts;
  @JsonKey(name: 'status_code')
  final String? statusCode;

  const ReceiptsModel({this.receipts, this.statusCode});

  factory ReceiptsModel.fromJson(Map<String, dynamic> json) {
    return _$ReceiptsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptsModelToJson(this);

  ReceiptsModel copyWith({
    List<Receipt>? receipts,
    String? statusCode,
  }) {
    return ReceiptsModel(
      receipts: receipts ?? this.receipts,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object?> get props => [receipts, statusCode];
}
