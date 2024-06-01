import 'package:json_annotation/json_annotation.dart';
part 'tasks_response.g.dart';

@JsonSerializable()
class TasksResponse {
  TasksResponse({
      this.id, 
      this.image, 
      this.title, 
      this.desc, 
      this.priority, 
      this.status, 
      this.user, 
      this.createdAt, 
      this.updatedAt, 
      this.v,
  });

  @JsonKey(name:'_id')
  String? id;
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name:'__v')
  int? v;

  factory TasksResponse.fromJson(Map<String,dynamic>json) => _$TasksResponseFromJson(json);


}