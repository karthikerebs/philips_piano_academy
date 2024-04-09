part of 'renewal_bloc.dart';

class RenewalState extends Equatable {
  const RenewalState(
      {this.status = const StatusInitial(),
      this.planList = const <Plan>[],
      this.feeDetailStatus = const StatusInitial(),
      this.feeDetails = const RenewalFeeDetails(),
      this.requestStatus = const StatusInitial(),
      this.renewalFees = const GetRenewalFeesModel(),
      this.checkRenewalStatus = const StatusInitial()});
  final Status status;
  final List<Plan> planList;
  final Status feeDetailStatus;
  final RenewalFeeDetails feeDetails;
  final Status requestStatus;
  final GetRenewalFeesModel renewalFees;
  final Status checkRenewalStatus;
  @override
  List<Object> get props => [
        status,
        planList,
        feeDetails,
        requestStatus,
        feeDetailStatus,
        renewalFees,
        renewalFees,
        checkRenewalStatus
      ];
  RenewalState copyWith(
      {Status? status,
      List<Plan>? planList,
      Status? feeDetailStatus,
      RenewalFeeDetails? feeDetails,
      Status? requestStatus,
      GetRenewalFeesModel? renewalFees,
      Status? checkRenewalStatus}) {
    return RenewalState(
        status: status ?? this.status,
        planList: planList ?? this.planList,
        feeDetailStatus: feeDetailStatus ?? this.feeDetailStatus,
        feeDetails: feeDetails ?? this.feeDetails,
        requestStatus: requestStatus ?? this.requestStatus,
        renewalFees: renewalFees ?? this.renewalFees,
        checkRenewalStatus: checkRenewalStatus ?? this.checkRenewalStatus);
  }
}
