import 'dart:async';
import 'dart:io';

class ApiFailure implements Exception {
  ApiFailure({required this.message});

  factory ApiFailure.from(Exception e) {
    if (e is SocketException) {
      return ApiFailure(message: 'No internet connection');
    } else if (e is HttpException) {
      return ApiFailure(message: 'Service loading failed');
    } else if (e is FormatException) {
      return ApiFailure(message: 'Invalid response');
    } else if (e is TimeoutException) {
      return ApiFailure(message: 'Request time out');
    } else {
      return ApiFailure(message: 'An unknown error occurred');
    }
  }

  final String message;
}
