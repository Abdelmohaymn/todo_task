
import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  RegisterResponse({
      this.id, 
      this.displayName, 
      this.accessToken, 
      this.refreshToken,
  });

  @JsonKey(name: '_id')
  String? id;
  String? displayName;
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  factory RegisterResponse.fromJson(Map<String,dynamic>json) => _$RegisterResponseFromJson(json);


}