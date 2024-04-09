import 'package:http/http.dart';
import 'package:music_app/src/infrastructure/core/internet_helper.dart';

abstract class IBaseClient {
  Future<Response> get({required String url, Map<String, String>? header});

  Future<ApiResponse> getWithProfile(
      {required String url, Map<String, String>? headers});

  Future<Response> post(
      {required String url, required Map<String, dynamic> body});

  Future<Response> postWithProfile(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? header});

  Future<Response> put(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, dynamic>? header});

  Future<Response> mediaUpload(
      {required String url,
      required String filePath,
      required String field,
      Map<String, dynamic>? header});
}
