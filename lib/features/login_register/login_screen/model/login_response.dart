
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse({
      this.id, 
      this.accessToken, 
      this.refreshToken,
  });

  String? id;
  String? accessToken;
  String? refreshToken;

  factory LoginResponse.fromJson(Map<String,dynamic>json) => _$LoginResponseFromJson(json);

}