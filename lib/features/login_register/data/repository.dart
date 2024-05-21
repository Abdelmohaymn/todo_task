
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:todo_task/features/login_register/login_screen/model/login_body.dart';
import 'package:todo_task/features/login_register/register_screen/model/register_body.dart';
import 'package:todo_task/features/login_register/register_screen/model/register_response.dart';
import 'package:todo_task/shared/network/remote/api_service.dart';

import '../../../shared/network/remote/api_result.dart';
import '../../../shared/network/remote/error_handler.dart';
import '../login_screen/model/login_response.dart';
import 'model/phone_model.dart';

class LogRegRepository{

  final ApiService _apiService;
  LogRegRepository(this._apiService);

  // get phones code
  Future<List<PhoneModel>> fetchPhonesCodeFromJson() async {
    // Load JSON file as a string
    String jsonString = await rootBundle.loadString('assets/jsons/phones.json');
    // Decode JSON string into Dart object
    List<dynamic> jsonList = json.decode(jsonString);
    // Convert List<dynamic> to List<DataModel>
    List<PhoneModel> data = jsonList.map((json) => PhoneModel.fromJson(json)).toList();

    return data;
  }

  Future<bool> validatePhoneNumber(String phoneNumber) async {
    try {
      final parsedNumber = await parse(phoneNumber);
      print('Valid phone number: ${parsedNumber['e164']}');
      return true;
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  //login
  Future<ApiResult<LoginResponse>> login(LoginBody loginBody) async{
    try{
      final response = await _apiService.login(loginBody);
      return ApiResult.success(response);
    }catch(error){
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  //register
  Future<ApiResult<RegisterResponse>> register(RegisterBody registerBody) async{
    try{
      final response = await _apiService.register(registerBody);
      return ApiResult.success(response);
    }catch(error){
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

}