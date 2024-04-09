import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/models/pm_models/pm_edit_profile_model/pm_edit_profile_model.dart';
import 'package:music_app/src/domain/models/response_models/activity_model/activity.dart';
import 'package:music_app/src/domain/models/response_models/basic_details_model/basic_details_model.dart';
import 'package:music_app/src/domain/models/response_models/notification_count_model/notification_count_model.dart';
import 'package:music_app/src/domain/models/response_models/profile_model/profile_model.dart';
import 'package:music_app/src/domain/profile/i_profile_repository.dart';

import '../../domain/models/response_models/receipts_model/receipt.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._iProfileRepository) : super(const ProfileState()) {
    on<GetProfileDataEvent>(_getProfileData);
    on<EditProfileEvent>(_editProfile);
    on<UploadProfileImageEvent>(_uploadImage);
    on<ChangePasswordEvent>(_changePassword);
    on<GetActivitiesEvent>(_getActivitesData);
    on<GetNotiFyCount>(_getNotifyCount);
    on<GetReceiptsEvent>(_getReceipts);
    on<GetBasicDetailsEvent>(_getBasicDetails);
  }
  FutureOr<void> _getProfileData(
      GetProfileDataEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iProfileRepository.getProfileData();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), profileData: res));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _editProfile(
      EditProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(editProfilestatus: StatusLoading()));
      final res = await _iProfileRepository.editProfile(params: event.params);
      if (res.statusCode == '01') {
        emit(state.copyWith(editProfilestatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            editProfilestatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(editProfilestatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(editProfilestatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _uploadImage(
      UploadProfileImageEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(uploadStatus: StatusLoading()));
      final res =
          await _iProfileRepository.uploadImage(filePath: event.filePath);
      if (res.statusCode == '01') {
        emit(state.copyWith(uploadStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            uploadStatus: StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(uploadStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(uploadStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _changePassword(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(changePasswordStatus: StatusLoading()));
      final res =
          await _iProfileRepository.changePassword(password: event.password);
      if (res.statusCode == '01') {
        emit(state.copyWith(changePasswordStatus: StatusSuccess()));
      } else {
        emit(state.copyWith(
            changePasswordStatus:
                StatusFailure(res.message ?? "Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(changePasswordStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(
          changePasswordStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getActivitesData(
      GetActivitiesEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(activityStatus: StatusLoading()));
      final res = await _iProfileRepository.getActivitiesData();
      if (res.activities!.isNotEmpty) {
        emit(state.copyWith(
            activityStatus: StatusSuccess(), activityList: res.activities));
      } else {
        emit(state.copyWith(
            activityStatus: StatusFailure("No activities found!")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(activityStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(activityStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getNotifyCount(
      GetNotiFyCount event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(countStatus: StatusLoading()));
      final res = await _iProfileRepository.getNotificationCount();
      if (res.statusCode == '01') {
        emit(state.copyWith(countStatus: StatusSuccess(), notifyCount: res));
      } else {
        emit(state.copyWith(countStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(countStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(countStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getReceipts(
      GetReceiptsEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(receiptsStatus: StatusLoading()));
      final res = await _iProfileRepository.getReceipts();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            receiptsStatus: StatusSuccess(), receiptsList: res.receipts));
      } else {
        emit(state.copyWith(
            receiptsStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(receiptsStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(receiptsStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getBasicDetails(
      GetBasicDetailsEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(detailsStatus: StatusLoading()));
      final res = await _iProfileRepository.getBasicDetails();
      if (res.statusCode == '01') {
        emit(state.copyWith(detailsStatus: StatusSuccess(), basicData: res));
      } else {
        emit(
            state.copyWith(detailsStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(detailsStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(detailsStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final IProfileRepository _iProfileRepository;
}
