

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/data/repository.dart';
import 'package:todo_task/shared/extensions.dart';

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
      value: 'Fresh',
      child: Text('Fresh'),
    ),
    const DropdownMenuItem(
      value: 'Junior',
      child: Text('Junior'),
    ),
    const DropdownMenuItem(
      value: 'Mid level',
      child: Text('Mid level'),
    ),
    const DropdownMenuItem(
      value: 'Senior',
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
      //call api;
    }
    emit(const LogRegStates.successCheckState());
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
      //call api;
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

}
