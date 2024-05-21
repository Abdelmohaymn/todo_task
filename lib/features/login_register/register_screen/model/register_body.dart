import 'package:json_annotation/json_annotation.dart';

part 'register_body.g.dart';

@JsonSerializable()
class RegisterBody {
  RegisterBody({
      this.phone, 
      this.password, 
      this.displayName, 
      this.experienceYears, 
      this.address, 
      this.level,});


  String? phone;
  String? password;
  String? displayName;
  int? experienceYears;
  String? address;
  String? level;

  Map<String,dynamic> toJson() => _$RegisterBodyToJson(this);

}