import 'package:json_annotation/json_annotation.dart';
part 'add_task_response.g.dart';

@JsonSerializable()
class AddTaskResponse {
  AddTaskResponse({
      this.image, 
      this.title, 
      this.desc, 
      this.priority, 
      this.status, 
      this.user, 
      this.id, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});


  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  factory AddTaskResponse.fromJson(Map<String,dynamic>json) => _$AddTaskResponseFromJson(json);


}