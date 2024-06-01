

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_task/features/profile_screen/models/profile_response.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/add_task_body.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/add_task_response.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/upload_image_body.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/upload_image_response.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/logout_body.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/logout_response.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/tasks_response.dart';
import 'package:todo_task/features/tasks/task_details_screen/models/edit_task_body.dart';
import '../../../shared/network/local/shared_pred_constants.dart';
import '../../../shared/network/local/shared_pref_helper.dart';
import '../../../shared/network/remote/api_result.dart';
import '../../../shared/network/remote/api_service.dart';
import '../../../shared/network/remote/error_handler.dart';
import '../../login_register/login_screen/model/login_response.dart';
import 'models/refresh_token_response.dart';

class TasksRepository{

  final ApiService _apiService;
  final ImagePicker _imagePicker;

  TasksRepository(this._apiService,this._imagePicker);

  Future<File?> pickImage() async{
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      return File(pickedImage.path);
    }
    return null;
  }

  //refresh
  Future<void> refreshToken() async{
    try{
      final response = await _apiService.refreshToken(
        token: SharedPrefHelper.getData(key: SharedPrefConstants.refreshTokenKey)
      );
        SharedPrefHelper.saveData(key: SharedPrefConstants.tokenKey, value: response.accessToken);
      }catch(error){
        print('REFRESH_TOKEN_ERROR${ErrorHandler.handle(error).apiErrorModel.message}');
      }
  }

  Future<ApiResult<T>> handleRefreshToken<T>(
      Future<ApiResult<T>> Function() apiFunction,
      ) async {
    try {
      return await apiFunction();
    } catch (error) {
      if (ErrorHandler.handle(error).apiErrorModel.statusCode == 401) {
        await refreshToken();
        return await apiFunction();
      } else {
        return ApiResult.failure(ErrorHandler.handle(error));
      }
    }
  }

  //logout
  Future<ApiResult<LogoutResponse>> logout() async{
    return handleRefreshToken<LogoutResponse>(
          () async {
        final response = await _apiService.logout(
          LogoutBody(token: SharedPrefHelper.getData(key: SharedPrefConstants.refreshTokenKey)),
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
        );
        return ApiResult.success(response);
      },
    );
  }

  //profile
  Future<ApiResult<ProfileResponse>> getProfile() async{
    return handleRefreshToken<ProfileResponse>(
          () async {
        final response = await _apiService.getProfileData(
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
        );
        return ApiResult.success(response);
      },
    );
  }

  Future<ApiResult<UploadImageResponse>> uploadImage(FormData image) async{
    return handleRefreshToken<UploadImageResponse>(
          () async {
        final response = await _apiService.uploadImage(
          image,
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
        );
        return ApiResult.success(response);
      },
    );
  }

  Future<ApiResult<AddTaskResponse>> addTask(AddTaskBody taskBody) async{
    return handleRefreshToken<AddTaskResponse>(
          () async {
        final response = await _apiService.addTask(
          taskBody,
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
        );
        return ApiResult.success(response);
      },
    );
  }

  Future<ApiResult<List<TasksResponse>>> getTasksList(int page) async{
    return handleRefreshToken<List<TasksResponse>>(
          () async {
        final response = await _apiService.getTasksList(
          page,
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
        );
        return ApiResult.success(response);
      },
    );
  }

  Future<ApiResult<TasksResponse>> getQRTask(String id) async{
    return handleRefreshToken<TasksResponse>(
          () async {
        final response = await _apiService.getQRTask(
          id,
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
        );
        return ApiResult.success(response);
      },
    );
  }

  Future<ApiResult<TasksResponse>> editTask(String id,EditTaskBody editTaskBody) async{
    return handleRefreshToken<TasksResponse>(
          () async {
        final response = await _apiService.editTask(
          id,
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
          editTaskBody
        );
        return ApiResult.success(response);
      },
    );
  }

  Future<ApiResult<TasksResponse>> deleteTask(String id) async{
    return handleRefreshToken<TasksResponse>(
          () async {
        final response = await _apiService.deleteTask(
          id,
          'Bearer ${SharedPrefHelper.getData(key: SharedPrefConstants.tokenKey)}',
        );
        return ApiResult.success(response);
      },
    );
  }


}