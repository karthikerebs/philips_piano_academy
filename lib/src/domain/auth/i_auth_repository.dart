import 'package:music_app/src/domain/models/pm_models/pm_register_model/pm_register_model.dart';
import 'package:music_app/src/domain/models/response_models/branch_model/branch_model.dart';
import 'package:music_app/src/domain/models/response_models/delete_response_model/delete_response_model.dart';
import 'package:music_app/src/domain/models/response_models/login_model/login_model.dart';
import 'package:music_app/src/domain/models/response_models/logout_model/logout_model.dart';
import 'package:music_app/src/domain/models/response_models/register_model/register_model.dart';

abstract class IAuthRepository {
  Future<bool> serverCheck();
  Future<LoginModel> login(
      {required String username,
      required String password,
      required String fcmToken});
  Future<RegisterModel> register({required PmRegisterModel pmRegisterModel});
  Future<BranchModel> getBranches();
  Future<LogoutModel> logout();
  Future<DeleteResponseModel> deleteAccount();
}
