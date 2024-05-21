

import '../../../shared/network/remote/api_service.dart';

class TasksRepository{

  final ApiService _apiService;
  TasksRepository(this._apiService);


  /*//login
  Future<ApiResult<LoginResponse>> login(LoginBody loginBody) async{
    try{
      final response = await _apiService.login(loginBody);
      return ApiResult.success(response);
    }catch(error){
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }*/



}