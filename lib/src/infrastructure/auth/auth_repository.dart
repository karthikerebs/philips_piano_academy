import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:music_app/src/domain/auth/i_auth_repository.dart';
import 'package:music_app/src/domain/core/app_url/app_urls.dart';
import 'package:music_app/src/domain/core/internet_service/i_base_client.dart';
import 'package:music_app/src/domain/core/pref_key/preference_key.dart';
import 'package:music_app/src/domain/models/pm_models/pm_register_model/pm_register_model.dart';
import 'package:music_app/src/domain/models/response_models/branch_model/branch_model.dart';
import 'package:music_app/src/domain/models/response_models/delete_response_model/delete_response_model.dart';
import 'package:music_app/src/domain/models/response_models/login_model/login_model.dart';
import 'package:music_app/src/domain/models/response_models/logout_model/logout_model.dart';
import 'package:music_app/src/domain/models/response_models/register_model/register_model.dart';
import 'package:music_app/src/infrastructure/core/preference_helper.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository extends IAuthRepository {
  final IBaseClient client;

  AuthRepository(this.client);
  @override
  Future<RegisterModel> register(
      {required PmRegisterModel pmRegisterModel}) async {
    try {
      final response = await client.post(
          url: AppUrls.registerUrl, body: pmRegisterModel.toJson());
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return RegisterModel.fromJson(decode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LoginModel> login(
      {required String username,
      required String password,
      required String fcmToken}) async {
    try {
      final response = await client.post(url: AppUrls.loginUrl, body: {
        "username": username,
        "password": password,
        "device_key": fcmToken
      });
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return LoginModel.fromJson(decode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BranchModel> getBranches() async {
    try {
      final response = await client.get(url: AppUrls.getBranchesUrl);
      final decode = jsonDecode(response.body) as Map<String, dynamic>;
      return BranchModel.fromJson(decode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> serverCheck() async {
    if (await PreferenceHelper().getBool(key: AppPrefeKeys.logged)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<LogoutModel> logout() async {
    try {
      final response = await client.getWithProfile(url: AppUrls.logoutUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return LogoutModel.fromJson(decode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DeleteResponseModel> deleteAccount() async {
    try {
      final response =
          await client.getWithProfile(url: AppUrls.deleteAccountUrl);
      final decode = jsonDecode(response.data) as Map<String, dynamic>;
      return DeleteResponseModel.fromJson(decode);
    } catch (e) {
      rethrow;
    }
  }
}
