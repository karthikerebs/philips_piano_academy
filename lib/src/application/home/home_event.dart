part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetBlogsDataEvent extends HomeEvent {
  const GetBlogsDataEvent();

  @override
  List<Object> get props => [];
}

class GetVideosDataEvent extends HomeEvent {
  const GetVideosDataEvent();

  @override
  List<Object> get props => [];
}

class GetHomeEvent extends HomeEvent {
  const GetHomeEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEvent extends HomeEvent {
  const GetNotificationEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentStatusEvent extends HomeEvent {
  const GetPaymentStatusEvent();

  @override
  List<Object> get props => [];
}
