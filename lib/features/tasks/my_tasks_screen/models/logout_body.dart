import 'package:json_annotation/json_annotation.dart';

part 'logout_body.g.dart';

@JsonSerializable()
class LogoutBody {
  LogoutBody({
      this.token,
  });

  String? token;

  Map<String,dynamic> toJson() => _$LogoutBodyToJson(this);


}