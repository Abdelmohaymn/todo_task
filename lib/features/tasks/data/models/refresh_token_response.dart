
import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_response.g.dart';

@JsonSerializable()
class RefreshTokenResponse {
  RefreshTokenResponse({
    this.accessToken,
  });

  @JsonKey(name: 'access_token')
  String? accessToken;

  factory RefreshTokenResponse.fromJson(Map<String,dynamic>json) => _$RefreshTokenResponseFromJson(json);

}