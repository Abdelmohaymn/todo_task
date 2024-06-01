

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/login_screen/model/login_body.dart';
import 'package:todo_task/features/login_register/data/repository.dart';
import 'package:todo_task/features/login_register/register_screen/model/register_body.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/network/local/shared_pred_constants.dart';
import 'package:todo_task/shared/network/local/shared_pref_helper.dart';

import '../data/model/phone_model.dart';
import 'log_reg_states.dart';


class LogRegCubit extends Cubit<LogRegStates> {

  final LogRegRepository _logRegRepo;
  LogRegCubit(this._logRegRepo) : super(const LogRegStates.initial());


  List<String> phonesCode=[];
  String chosenCountry='🇪🇬 +20';
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController expController = TextEditingController();
  bool isPassVisible=true;

  String? exp;
  List<DropdownMenuItem<String>> levels=[
    const DropdownMenuItem(
      value: 'fresh',
      child: Text('Fresh'),
    ),
    const DropdownMenuItem(
      value: 'junior',
      child: Text('Junior'),
    ),
    const DropdownMenuItem(
      value: 'midLevel',
      child: Text('Mid level'),
    ),
    const DropdownMenuItem(
      value: 'senior',
      child: Text('Senior'),
    ),
  ];

  // validation variables
  bool isPhone=false;
  bool isPass=false;
  bool isName=false;
  bool isExperience=false;
  bool isExperience2=false;
  bool isAddress=false;

  void getPhonesCode() async{
    emit(const LogRegStates.loadJsonData());
    List<PhoneModel> countries = await _logRegRepo.fetchPhonesCodeFromJson();
    for(PhoneModel country in countries){
      phonesCode.add('${country.flag} ${country.dialCode}');
    }
    emit(const LogRegStates.successJsonData());
  }

  void changeCountry(String value){
    emit(const LogRegStates.loadChangeCountry());
    chosenCountry = value;
    emit(const LogRegStates.successChangeCountry());
  }

  void changeExpLevel(String value){
    emit(const LogRegStates.loadChangeExpLevel());
    exp = value;
    emit(const LogRegStates.successChangeExpLevel());
  }

  void changePassVisibility(){
    emit(const LogRegStates.loadChangeVisibleState());
    isPassVisible=!isPassVisible;
    emit(const LogRegStates.successChangeVisibleState());
  }

  Future<void> loginUser() async {
    emit(const LogRegStates.loadCheckState());
    isPhone = !await validatePhoneNumber();//phoneController.text.isNotBlank()?false:true;
    isPass = passController.text.isNotBlank()?false:true;
    if(!isPhone&&!isPass){
      emitLoginStates();
    }else{
      emit(const LogRegStates.successCheckState());
    }
  }

  Future<void> registerUser() async {
    emit(const LogRegStates.loadCheckState());
    isPhone = !await validatePhoneNumber();
    isName = nameController.text.isNotBlank()?false:true;
    isExperience = expController.text.isNotBlank()?false:true;
    isExperience2 = exp!=null?false:true;
    isAddress = addressController.text.isNotBlank()?false:true;
    isPass = passController.text.isNotBlank()?false:true;
    if(!isPhone&&!isName&&!isExperience&&!isExperience2&&!isAddress&&!isPass){
      emitRegisterStates();
    }
    emit(const LogRegStates.successCheckState());
  }

  Future<bool> validatePhoneNumber() async {
    String phone = chosenCountry.getDialCode()+phoneController.text;
    if(await _logRegRepo.validatePhoneNumber(phone)){
      return true;
    }
    return false;
  }

  void clearData(){
    emit(const LogRegStates.loadCheckState());
    chosenCountry='🇪🇬 +20';
    phoneController.clear();
    passController.clear();
    nameController.clear();
    addressController.clear();
    expController.clear();
    isPassVisible=true;
    exp=null;
    isPhone=false;
    isPass=false;
    isName=false;
    isExperience=false;
    isExperience2=false;
    isAddress=false;
    emit(const LogRegStates.successCheckState());
  }

  void emitLoginStates() async {
    emit(const LogRegStates.loadLoginUser());
    final response = await _logRegRepo.login(
      LoginBody(
        phone: chosenCountry.getDialCode()+phoneController.text,
        password: passController.text
      )
    );
    response.when(
        success: (data)async{
          await SharedPrefHelper.saveData(key: SharedPrefConstants.tokenKey, value: data.accessToken!);
          await SharedPrefHelper.saveData(key: SharedPrefConstants.refreshTokenKey, value: data.refreshToken!);
          emit(LogRegStates.successLoginUser(data));
        },
        failure: (error){
          emit(LogRegStates.errorLoginUser(error: error.apiErrorModel.message!));
        }
    );
  }

  void emitRegisterStates() async {
    emit(const LogRegStates.loadRegisterUser());
    final response = await _logRegRepo.register(
        RegisterBody(
          phone: chosenCountry.getDialCode()+phoneController.text,
          password: passController.text,
          displayName: nameController.text,
          experienceYears: int.parse(expController.text),
          address: addressController.text,
          level: exp,
        )
    );
    response.when(
        success: (data) async {
          await SharedPrefHelper.saveData(key: SharedPrefConstants.tokenKey, value: data.accessToken!);
          await SharedPrefHelper.saveData(key: SharedPrefConstants.refreshTokenKey, value: data.refreshToken!);
          emit(LogRegStates.successRegisterUser(data));
        },
        failure: (error){
          emit(LogRegStates.errorRegisterUser(error: error.apiErrorModel.message!));
        }
    );
  }

}
