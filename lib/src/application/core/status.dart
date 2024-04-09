import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class Status extends Equatable {
  const Status();
  @override
  List<Object> get props => [];
}

class StatusInitial extends Status {
  const StatusInitial();
}

class StatusLoading extends Status {}

class StatusSuccess extends Status {}

class StatusFailure extends Status {
  const StatusFailure(this.errorMessage);

  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class StatusAuthFailure extends Status {
  const StatusAuthFailure(this.errorMessage);

  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
