import 'package:json_annotation/json_annotation.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  ProfileResponse({
      this.id, 
      this.displayName, 
      this.username, 
      this.roles, 
      this.active, 
      this.experienceYears, 
      this.address, 
      this.level, 
      this.createdAt, 
      this.updatedAt, 
      this.v,
  });


  @JsonKey(name: '_id')
  String? id;
  String? displayName;
  String? username;
  List<String>? roles;
  bool? active;
  int? experienceYears;
  String? address;
  String? level;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  factory ProfileResponse.fromJson(Map<String,dynamic>json) => _$ProfileResponseFromJson(json);


}