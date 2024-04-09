// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pm_slot_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PmSlotBookingModel _$PmSlotBookingModelFromJson(Map<String, dynamic> json) =>
    PmSlotBookingModel(
      sloteId: json['slote_id'] as String?,
      planId: json['plan_id'] as String?,
      payType: json['pay_type'] as String?,
      joiningDate: json['joining_date'] as String?,
      validFrom: json['valid_from'] as String?,
      validTo: json['valid_to'] as String?,
      fee: json['fee'] as String?,
      extraFee: json['extra_fee'] as String?,
      deposit: json['deposit'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paidAmount: json['paid_amount'] as String?,
      referenceId: json['reference_id'] as String?,
    );

Map<String, dynamic> _$PmSlotBookingModelToJson(PmSlotBookingModel instance) =>
    <String, dynamic>{
      'slote_id': instance.sloteId,
      'plan_id': instance.planId,
      'pay_type': instance.payType,
      'joining_date': instance.joiningDate,
      'valid_from': instance.validFrom,
      'valid_to': instance.validTo,
      'fee': instance.fee,
      'extra_fee': instance.extraFee,
      'deposit': instance.deposit,
      'payment_method': instance.paymentMethod,
      'paid_amount': instance.paidAmount,
      'reference_id': instance.referenceId,
    };
