import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/src/application/core/status.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/home/i_home_repository.dart';
import 'package:music_app/src/domain/models/response_models/blog_model/blog.dart';
import 'package:music_app/src/domain/models/response_models/get_payment_status_model/get_payment_status_model.dart';
import 'package:music_app/src/domain/models/response_models/home_data_model/home_data_model.dart';
import 'package:music_app/src/domain/models/response_models/notification_model/notification.dart';
import 'package:music_app/src/domain/models/response_models/tutorial_video_model/video.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._iHomeRepository) : super(const HomeState()) {
    on<GetBlogsDataEvent>(_getBlogsList);
    on<GetVideosDataEvent>(_getVideosList);
    on<GetHomeEvent>(_getHomeData);
    on<GetNotificationEvent>(_getNotifications);
    on<GetPaymentStatusEvent>(_getPaymentStatus);
  }
  FutureOr<void> _getBlogsList(
      GetBlogsDataEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iHomeRepository.getBlogsData();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), blogList: res.blogs));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getVideosList(
      GetVideosDataEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iHomeRepository.getTutorialVideos();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), videoList: res.videos));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getHomeData(
      GetHomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: StatusLoading()));
      final res = await _iHomeRepository.getHomeData();
      if (res.statusCode == '01') {
        emit(state.copyWith(status: StatusSuccess(), homeData: res));
      } else {
        emit(state.copyWith(status: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(status: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(status: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getNotifications(
      GetNotificationEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(notificationStatus: StatusLoading()));
      final res = await _iHomeRepository.getNotifications();
      if (res.statusCode == '01') {
        emit(state.copyWith(
            notificationStatus: StatusSuccess(),
            notificationList: res.notifications));
      } else {
        emit(state.copyWith(
            notificationStatus: const StatusFailure("Request fail")));
      }
    } on ApiFailure catch (e) {
      emit(state.copyWith(notificationStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(
          state.copyWith(notificationStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  FutureOr<void> _getPaymentStatus(
      GetPaymentStatusEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(paymentStatus: StatusLoading()));
      final res = await _iHomeRepository.getPaymentStatus();
      emit(state.copyWith(
          paymentStatus: StatusSuccess(), paymentStatusData: res));
    } on ApiFailure catch (e) {
      emit(state.copyWith(paymentStatus: StatusFailure(e.message)));
    } on ApiAuthFailure catch (e) {
      emit(state.copyWith(paymentStatus: StatusAuthFailure(e.error ?? "")));
    }
  }

  final IHomeRepository _iHomeRepository;
}
