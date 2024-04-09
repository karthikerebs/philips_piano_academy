// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    HomeDataModel(
      name: json['name'] as String?,
      status: json['status'] as String?,
      approval: json['approval'] as String?,
      slote: json['slote'] as int?,
      sloteTime: json['slote_time'] as String?,
      nextClass: json['next_class'] as String?,
      upcomingClass: (json['upcoming_class'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      creditClass: (json['credit_class'] as List<dynamic>?)
          ?.map((e) => CreditClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingInstallments: json['pending_installments'] as List<dynamic>?,
      statusCode: json['status_code'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$HomeDataModelToJson(HomeDataModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'approval': instance.approval,
      'slote': instance.slote,
      'slote_time': instance.sloteTime,
      'next_class': instance.nextClass,
      'upcoming_class': instance.upcomingClass,
      'credit_class': instance.creditClass,
      'pending_installments': instance.pendingInstallments,
      'status_code': instance.statusCode,
      'mobile': instance.mobile,
      'email': instance.email,
    };
