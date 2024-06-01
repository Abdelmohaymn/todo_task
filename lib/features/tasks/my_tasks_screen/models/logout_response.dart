import 'package:json_annotation/json_annotation.dart';
part 'logout_response.g.dart';

@JsonSerializable()
class LogoutResponse {
  LogoutResponse({
      this.success,
  });


  bool? success;

  factory LogoutResponse.fromJson(Map<String,dynamic>json) => _$LogoutResponseFromJson(json);

}