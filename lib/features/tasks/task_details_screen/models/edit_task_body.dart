import 'package:json_annotation/json_annotation.dart';

part 'edit_task_body.g.dart';

@JsonSerializable()
class EditTaskBody {
  EditTaskBody({
      this.status,
  });


  String? status;

  Map<String,dynamic> toJson() => _$EditTaskBodyToJson(this);

}