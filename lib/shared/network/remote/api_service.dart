

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_task/features/login_register/login_screen/model/login_body.dart';
import 'package:todo_task/features/login_register/login_screen/model/login_response.dart';
import 'package:todo_task/features/login_register/register_screen/model/register_body.dart';
import 'package:todo_task/features/login_register/register_screen/model/register_response.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/add_task_body.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/add_task_response.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/upload_image_response.dart';
import 'package:todo_task/features/tasks/data/models/refresh_token_response.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/logout_body.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/tasks_response.dart';
import 'package:todo_task/features/tasks/task_details_screen/models/edit_task_body.dart';


import '../../../features/profile_screen/models/profile_response.dart';
import '../../../features/tasks/my_tasks_screen/models/logout_response.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
      @Body() LoginBody loginBody
  );

  @POST(ApiConstants.register)
  Future<RegisterResponse> register(
      @Body() RegisterBody registerBody
  );

  @GET(ApiConstants.refreshToken)
  Future<RefreshTokenResponse> refreshToken({
    @Query('token') required String token,
  });

  ///
  @POST(ApiConstants.logout)
  Future<LogoutResponse> logout(
    @Body() LogoutBody logoutBody,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.profile)
  Future<ProfileResponse> getProfileData(
    @Header('Authorization') String token,
  );

  @POST(ApiConstants.uploadImage)
  Future<UploadImageResponse> uploadImage(
    @Body() FormData image,
    @Header('Authorization') String token,
  );

  @POST(ApiConstants.tasks)
  Future<AddTaskResponse> addTask(
    @Body() AddTaskBody taskBody,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.tasks)
  Future<List<TasksResponse>> getTasksList(
    @Query('page') int page,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.taskID)
  Future<TasksResponse> getQRTask(
    @Path("id") String id,
    @Header('Authorization') String token,
  );

  @PUT(ApiConstants.taskID)
  Future<TasksResponse> editTask(
    @Path("id") String id,
    @Header('Authorization') String token,
    @Body() EditTaskBody editTaskBody,
  );

  @DELETE(ApiConstants.taskID)
  Future<TasksResponse> deleteTask(
    @Path("id") String id,
    @Header('Authorization') String token,
  );

}