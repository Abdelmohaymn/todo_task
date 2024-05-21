

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_task/features/login_register/login_screen/model/login_body.dart';
import 'package:todo_task/features/login_register/login_screen/model/login_response.dart';
import 'package:todo_task/features/login_register/register_screen/model/register_body.dart';
import 'package:todo_task/features/login_register/register_screen/model/register_response.dart';

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


}