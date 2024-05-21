
import 'package:json_annotation/json_annotation.dart';

part 'login_body.g.dart';

@JsonSerializable()
class LoginBody {
  LoginBody({
      this.phone, 
      this.password,
  });

  String? phone;
  String? password;

  Map<String,dynamic> toJson() => _$LoginBodyToJson(this);

}