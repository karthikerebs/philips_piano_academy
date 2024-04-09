import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receipt.g.dart';

@JsonSerializable()
class Receipt extends Equatable {
  final int? id;
  final String? type;
  final int? fee;
  @JsonKey(name: 'extra_fee')
  final dynamic extraFee;
  @JsonKey(name: 'extra_class_fee')
  final dynamic extraClassFee;
  @JsonKey(name: 'payment_date')
  final String? paymentDate;
  final int? student;
  final dynamic deposit;
  final String? status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const Receipt({
    this.id,
    this.type,
    this.fee,
    this.extraFee,
    this.extraClassFee,
    this.paymentDate,
    this.student,
    this.deposit,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return _$ReceiptFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);

  Receipt copyWith({
    int? id,
    String? type,
    int? fee,
    dynamic extraFee,
    dynamic extraClassFee,
    String? paymentDate,
    int? student,
    dynamic deposit,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Receipt(
      id: id ?? this.id,
      type: type ?? this.type,
      fee: fee ?? this.fee,
      extraFee: extraFee ?? this.extraFee,
      extraClassFee: extraClassFee ?? this.extraClassFee,
      paymentDate: paymentDate ?? this.paymentDate,
      student: student ?? this.student,
      deposit: deposit ?? this.deposit,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      type,
      fee,
      extraFee,
      extraClassFee,
      paymentDate,
      student,
      deposit,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
