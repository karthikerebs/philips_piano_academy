import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/core/failures/api_auth_failure.dart';
import 'package:music_app/src/domain/core/failures/api_failure.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/core/pref_key/preference_key.dart';

import 'preference_helper.dart';

@LazySingleton(as: IBaseClient)
class InternetHelper extends IBaseClient {
  InternetHelper(this.client);
  final http.Client client;

  @override
  Future<http.Response> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        body: body,
      );
      if (response.body.isEmpty) {
        throw ApiFailure(message: 'no data found');
      }
      return _response(response);
    } on SocketException {
      throw ApiFailure(message: 'Internet service not found!');
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.message);
    } on TimeoutException {
      throw ApiFailure(message: 'Time out');
    } catch (e) {
      throw ApiFailure(message: 'something went worng !');
    }
  }

  @override
  Future<http.Response> put({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? header,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> postWithProfile({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    try {
      final accessToken =
          await PreferenceHelper().getString(key: AppPrefeKeys.token);
      if (accessToken.isEmpty) {
        throw ApiFailure(message: 'access token is empty');
      }
      final header = {
        'Authorization': 'Bearer $accessToken',
      };
      Map<String, String> data = Map<String, String>.from(body);
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(data);
      request.headers.addAll(header);
      var response = await request.send();
      final respStr = await http.Response.fromStream(response);
      if (respStr.body.isEmpty) {
        throw ApiFailure(message: 'no data found');
      }
      log(respStr.body);
      return _response(respStr);
    } on SocketException {
      throw ApiFailure;
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.message);
    } on TimeoutException {
      throw ApiFailure;
    } on http.ClientException catch (e) {
      if (e.message.contains('401')) {
        throw ApiAuthFailure('Authentication Failed');
      } else {
        throw ApiFailure(message: e.message);
      }
    } catch (e) {
      throw ApiAuthFailure(e.toString());
    }
  }

  @override
  Future<ApiResponse> getWithProfile(
      {required String url, Map<String, String>? headers}) async {
    final accessToken =
        await PreferenceHelper().getString(key: AppPrefeKeys.token);
    final response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return processResponse(response);
    } else {
      final apiResponse = await processResponse(response);
      if (apiResponse.errorMessage != null) {
        throw ApiAuthFailure(apiResponse.errorMessage!);
      } else {
        throw ApiFailure(message: 'Something went wrong');
      }
    }
/*     try {
      final accessToken =
          await PreferenceHelper().getString(key: AppPrefeKeys.token);
      if (accessToken.isEmpty) {
        throw ApiFailure(message: 'access token is empty');
      }
      final header = {
        'Authorization': 'Bearer $accessToken',
      };
      final response = await client.get(Uri.parse(url), headers: header);
      if (response.body.isEmpty) {
        throw ApiFailure(message: 'no data found');
      }
      return processResponse(response);
    } on SocketException {
      throw ApiFailure;
    } on ApiFailure catch (e) {
      log(e.message);
      throw ApiFailure;
    } on TimeoutException {
      throw ApiFailure;
    } catch (e) {
      throw ApiAuthFailure(e.toString());
    } */
  }

  @override
  Future<http.Response> mediaUpload({
    required String url,
    required String filePath,
    required String field,
    Map<String, dynamic>? header,
  }) async {
    try {
      final accessToken =
          await PreferenceHelper().getString(key: AppPrefeKeys.token);
      if (accessToken.isEmpty) {
        throw ApiFailure(message: 'access token is empty');
      }

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({'Authorization': 'Bearer $accessToken'});
      request.files.add(
        await http.MultipartFile.fromPath(field, filePath),
      );
      final res = await request.send();
      final response = await http.Response.fromStream(res);
      if (response.body.isEmpty) {
        throw ApiFailure(message: 'no data found');
      }
      return _response(response);
    } on SocketException {
      throw ApiFailure;
    } on ApiFailure catch (e) {
      log(e.message);
      throw ApiFailure;
    } on TimeoutException {
      throw ApiFailure;
    } catch (e) {
      throw ApiFailure;
    }
  }

  http.Response _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 500:
        if (response.body.contains('message')) {
          return response;
        } else {
          throw ApiFailure(
              message: 'Internal Server Error. Please try again later');
        }
      case 400:
        if (response.body.contains('message')) {
          return response;
        } else {
          throw ApiFailure(
              message:
                  'Something went wrong. Please check your request and try again');
        }
      case 401:
        throw ApiAuthFailure("Unauthenticated");
      case 404:
        if (response.body.contains('message')) {
          return response;
        } else {
          throw ApiAuthFailure('Authentication expired');
        }
      default:
        throw ApiFailure(message: 'Something went wrong');
    }
  }

  @override
  Future<http.Response> get(
      {required String url, Map<String, String>? header}) async {
    try {
      final response = await client.get(Uri.parse(url), headers: header);
      if (response.body.isEmpty) {
        throw ApiFailure(message: 'no data found');
      }
      return _response(response);
    } on SocketException {
      throw ApiFailure;
    } on ApiFailure catch (e) {
      log(e.message);
      throw ApiFailure;
    } on TimeoutException {
      throw ApiFailure;
    } on http.ClientException catch (e) {
      if (e.message.contains('401')) {
        throw ApiAuthFailure('Authentication Failed');
      } else {
        throw ApiFailure(message: e.message);
      }
    } catch (e) {
      throw ApiAuthFailure(e.toString());
    }
  }

  ApiResponse<T> handleClientError<T>(dynamic responseData) {
    Map<String, dynamic> responseMap = jsonDecode(responseData);
    final errorMessage = responseMap['message'] ??
        'Something went wrong. Please check your request and try again';
    return ApiResponse<T>(statusCode: 400, errorMessage: errorMessage);
  }

  ApiResponse<T> handleServerError<T>(dynamic responseData) {
    final errorMessage = responseData['message'] ??
        'Internal Server Error. Please try again later';
    return ApiResponse<T>(statusCode: 500, errorMessage: errorMessage);
  }

  Future<ApiResponse<T>> processResponse<T>(http.Response response) async {
    final statusCode = response.statusCode;
    final responseData = response.body.isEmpty ? null : response.body;

    switch (statusCode) {
      case 200:
      case 201:
        return ApiResponse<T>(statusCode: statusCode, data: responseData as T);
      case 400:
        return handleClientError(responseData);
      case 401:
        return ApiResponse<T>(
            statusCode: statusCode, errorMessage: 'Unauthenticated');
      case 404:
        return ApiResponse<T>(
            statusCode: statusCode, errorMessage: 'Resource not found');
      case 500:
        return handleServerError(responseData);
      default:
        return ApiResponse<T>(
            statusCode: statusCode, errorMessage: 'Unknown error occurred');
    }
  }
}

class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final String? errorMessage;

  ApiResponse({required this.statusCode, this.data, this.errorMessage});
}
