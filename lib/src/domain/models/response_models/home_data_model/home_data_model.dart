import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'credit_class.dart';

part 'home_data_model.g.dart';

@JsonSerializable()
class HomeDataModel extends Equatable {
  final String? name;
  final String? status;
  final String? approval;
  final int? slote;
  @JsonKey(name: 'slote_time')
  final String? sloteTime;
  @JsonKey(name: 'next_class')
  final String? nextClass;
  @JsonKey(name: 'upcoming_class')
  final List<String>? upcomingClass;
  @JsonKey(name: 'credit_class')
  final List<CreditClass>? creditClass;
  @JsonKey(name: 'pending_installments')
  final List<dynamic>? pendingInstallments;
  @JsonKey(name: 'status_code')
  final String? statusCode;
  final String? mobile;
  final String? email;

  const HomeDataModel(
      {this.name,
      this.status,
      this.approval,
      this.slote,
      this.sloteTime,
      this.nextClass,
      this.upcomingClass,
      this.creditClass,
      this.pendingInstallments,
      this.statusCode,
      this.mobile,
      this.email});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return _$HomeDataModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeDataModelToJson(this);

  HomeDataModel copyWith(
      {String? name,
      String? status,
      String? approval,
      int? slote,
      String? sloteTime,
      String? nextClass,
      List<String>? upcomingClass,
      List<CreditClass>? creditClass,
      List<dynamic>? pendingInstallments,
      String? statusCode,
      String? mobile,
      String? email}) {
    return HomeDataModel(
        name: name ?? this.name,
        status: status ?? this.status,
        approval: approval ?? this.approval,
        slote: slote ?? this.slote,
        sloteTime: sloteTime ?? this.sloteTime,
        nextClass: nextClass ?? this.nextClass,
        upcomingClass: upcomingClass ?? this.upcomingClass,
        creditClass: creditClass ?? this.creditClass,
        pendingInstallments: pendingInstallments ?? this.pendingInstallments,
        statusCode: statusCode ?? this.statusCode,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email);
  }

  @override
  List<Object?> get props {
    return [
      name,
      status,
      approval,
      slote,
      sloteTime,
      nextClass,
      upcomingClass,
      creditClass,
      pendingInstallments,
      statusCode,
      mobile,
      email
    ];
  }
}
