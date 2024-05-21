
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  RegisterResponse({
      this.id, 
      this.displayName, 
      this.accessToken, 
      this.refreshToken,});

  String? id;
  String? displayName;
  String? accessToken;
  String? refreshToken;

  factory RegisterResponse.fromJson(Map<String,dynamic>json) => _$RegisterResponseFromJson(json);


}