import 'package:json_annotation/json_annotation.dart';

part 'add_task_body.g.dart';

@JsonSerializable()
class AddTaskBody {
  AddTaskBody({
      this.image, 
      this.title, 
      this.desc, 
      this.priority, 
      this.dueDate,
  });


  String? image;
  String? title;
  String? desc;
  String? priority;
  String? dueDate;

  Map<String,dynamic> toJson() => _$AddTaskBodyToJson(this);

}