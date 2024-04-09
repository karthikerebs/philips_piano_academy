part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = const StatusInitial(),
    this.blogStatus = const StatusInitial(),
    this.videoStatus = const StatusInitial(),
    this.blogList = const <Blog>[],
    this.videoList = const <Video>[],
    this.homeData = const HomeDataModel(),
    this.notificationStatus = const StatusInitial(),
    this.notificationList = const <Notification>[],
    this.paymentStatusData = const GetPaymentStatusModel(),
    this.paymentStatus = const StatusInitial(),
  });
  final Status status;
  final Status blogStatus;
  final Status videoStatus;
  final List<Blog> blogList;
  final List<Video> videoList;
  final HomeDataModel homeData;
  final Status notificationStatus;
  final List<Notification> notificationList;
  final GetPaymentStatusModel paymentStatusData;
  final Status paymentStatus;
  @override
  List<Object> get props => [
        status,
        blogStatus,
        videoStatus,
        blogList,
        videoList,
        homeData,
        notificationStatus,
        notificationList,
        paymentStatusData,
        paymentStatus,
      ];
  HomeState copyWith({
    Status? status,
    Status? blogStatus,
    Status? videoStatus,
    List<Blog>? blogList,
    List<Video>? videoList,
    HomeDataModel? homeData,
    Status? notificationStatus,
    List<Notification>? notificationList,
    GetPaymentStatusModel? paymentStatusData,
    Status? paymentStatus,
  }) {
    return HomeState(
      status: status ?? this.status,
      blogStatus: blogStatus ?? this.blogStatus,
      videoStatus: videoStatus ?? this.videoStatus,
      blogList: blogList ?? this.blogList,
      videoList: videoList ?? this.videoList,
      homeData: homeData ?? this.homeData,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      notificationList: notificationList ?? this.notificationList,
      paymentStatusData: paymentStatusData ?? this.paymentStatusData,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}
