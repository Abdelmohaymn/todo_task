
import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse({
      this.id, 
      this.accessToken, 
      this.refreshToken,
  });

  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  factory LoginResponse.fromJson(Map<String,dynamic>json) => _$LoginResponseFromJson(json);

}