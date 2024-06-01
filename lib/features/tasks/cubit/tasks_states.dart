
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
  const factory TasksStates.cameraLoaded() = CameraLoaded;
  const factory TasksStates.cameraInitialized() = CameraInitialized;
  const factory TasksStates.cameraFailed() = CameraFailed;
  const factory TasksStates.capturedImage() = ImageCaptured;
  const factory TasksStates.loadDeleteImage() = LoadDeleteImage;
  const factory TasksStates.successDeleteImage() = SuccessDeleteImage;
  const factory TasksStates.loadOpenGallery() = LoadOpenGallery;
  const factory TasksStates.successOpenGallery() = SuccessOpenGallery;

  const factory TasksStates.loadLogout() = LoadLogout;
  const factory TasksStates.successLogout() = SuccessLogout;
  const factory TasksStates.errorLogout({required String error}) = ErrorLogout;

  const factory TasksStates.loadProfile() = LoadProfile;
  const factory TasksStates.successProfile() = SuccessProfile;
  const factory TasksStates.errorProfile({required String error}) = ErrorProfile;


  const factory TasksStates.loadAddTask() = LoadAddTask;
  const factory TasksStates.successAddTask() = SuccessAddTask;
  const factory TasksStates.errorAddTask({required String error}) = ErrorAddTask;

  const factory TasksStates.loadUploadImage() = LoadUploadImage;
  const factory TasksStates.successUploadImage() = SuccessUploadImage;
  const factory TasksStates.errorUploadImage({required String error}) = ErrorUploadImage;

  const factory TasksStates.loadGetTasksList() = LoadGetTasksList;
  const factory TasksStates.successGetTasksList() = SuccessGetTasksList;
  const factory TasksStates.errorGetTasksList({required String error}) = ErrorGetTasksList;

  const factory TasksStates.loadGetQRTask() = LoadGetQRTask;
  const factory TasksStates.successGetQRTask(T data) = SuccessGetQRTask;
  const factory TasksStates.errorGetQRTask({required String error}) = ErrorGetQRTask;

  const factory TasksStates.loadEditTask() = LoadEditTask;
  const factory TasksStates.successEditTask() = SuccessEditTask;
  const factory TasksStates.errorEditTask({required String error}) = ErrorEditTask;

  const factory TasksStates.loadDeleteTask() = LoadDeleteTask;
  const factory TasksStates.successDeleteTask() = SuccessDeleteTask;
  const factory TasksStates.errorDeleteTask({required String error}) = ErrorDeleteTask;

}
