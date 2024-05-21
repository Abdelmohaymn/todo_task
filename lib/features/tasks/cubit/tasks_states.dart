
import 'package:freezed_annotation/freezed_annotation.dart';
part 'tasks_states.freezed.dart';

@Freezed()
class TasksStates<T> with _$TasksStates<T>{
  const factory TasksStates.initial() = _Initial;
  const factory TasksStates.loadChangeCollection() = LoadChangeCollection;
  const factory TasksStates.successChangeCollection() = SuccessChangeCollection;
  const factory TasksStates.loadPickDate() = LoadPickDate;
  const factory TasksStates.successPickDate() = SuccessPickDate;
  const factory TasksStates.loadCheckState() = LoadCheckState;
  const factory TasksStates.successCheckState() = SuccessCheckState;


}
