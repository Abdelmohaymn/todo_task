
import 'package:freezed_annotation/freezed_annotation.dart';
part 'log_reg_states.freezed.dart';

@Freezed()
class LogRegStates<T> with _$LogRegStates<T>{
  const factory LogRegStates.initial() = _Initial;
  const factory LogRegStates.loadJsonData() = LoadJsonData;
  const factory LogRegStates.successJsonData() = SuccessJsonData;
  const factory LogRegStates.loadChangeCountry() = LoadChangeCountry;
  const factory LogRegStates.successChangeCountry() = SuccessChangeCountry;
  const factory LogRegStates.loadChangeVisibleState() = LoadChangeVisibleState;
  const factory LogRegStates.successChangeVisibleState() = SuccessChangeVisibleState;
  const factory LogRegStates.loadCheckState() = LoadCheckState;
  const factory LogRegStates.successCheckState() = SuccessCheckState;
  const factory LogRegStates.loadChangeExpLevel() = LoadChangeExpLevel;
  const factory LogRegStates.successChangeExpLevel() = SuccessChangeExpLevel;
  //login
  const factory LogRegStates.loadLoginUser() = LoadLoginUser;
  const factory LogRegStates.successLoginUser(T data) = SuccessLoginUser;
  const factory LogRegStates.errorLoginUser({required String error}) = ErrorLoginUser;
  //register
  const factory LogRegStates.loadRegisterUser() = LoadRegisterUser;
  const factory LogRegStates.successRegisterUser(T data) = SuccessRegisterUser;
  const factory LogRegStates.errorRegisterUser({required String error}) = ErrorRegisterUser;

}
