
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/add_task_body.dart';
import 'package:todo_task/features/tasks/add_task_screen/model/upload_image_body.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/features/tasks/data/tasks_repository.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/tasks_response.dart';
import 'package:todo_task/features/tasks/task_details_screen/models/edit_task_body.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/styles/text_styles.dart';

import '../../../shared/widget_functions.dart';
import '../../profile_screen/models/profile_response.dart';

class TasksCubit extends Cubit<TasksStates> {

  final TasksRepository _tasksRepository;
  TasksCubit(this._tasksRepository) : super(const TasksStates.initial());

  ProfileResponse? profile;

  List<String> collections=['All', 'Inprogress', 'Waiting', 'Finished'];
  int chosenCollection=0,page=1;
  List<TasksResponse>_tasks=[],tasks=[];
  bool requestMorePages=true;

  List<DropdownMenuItem<String>> priorities=[
    DropdownMenuItem(
      value: 'low',
      child: Text(
        'Low Priority',
        style: GoogleFonts.dmSans(
          textStyle: TextStyles.font16Default700
        ),
      )
    ),
    DropdownMenuItem(
        value: 'medium',
        child: Text(
          'Medium Priority',
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font16Default700
          ),
        )
    ),
    DropdownMenuItem(
        value: 'high',
        child: Text(
          'High Priority',
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font16Default700
          ),
        )
    ),
  ];

  List<DropdownMenuItem<String>> taskStatus=[
    DropdownMenuItem(
        value: 'waiting',
        child: Text(
          'Waiting',
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font16Default700
          ),
        )
    ),
    DropdownMenuItem(
        value: 'inProgress',
        child: Text(
          'InProgress',
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font16Default700
          ),
        )
    ),
    DropdownMenuItem(
        value: 'finished',
        child: Text(
          'Finished',
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font16Default700
          ),
        )
    ),
  ];

  String? priority, date;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  File? pickedImage;
  // validation
  bool isTitle=false;
  bool isDescription=false;
  bool isPriority=false;
  bool isDate=false;
  bool isImage=false;



  void changeCollection(int index){
    emit(const TasksStates.loadChangeCollection());
    chosenCollection = index;
    checkListOfCollection();
    emit(const TasksStates.successChangeCollection());
  }

  void checkListOfCollection(){
    switch(chosenCollection){
      case 0: tasks = _tasks;
      case 1: putTasksToCollection('inProgress');
      case 2: putTasksToCollection('waiting');
      case 3: putTasksToCollection('finished');
    }
  }

  void putTasksToCollection(String status){
    tasks=[];
    for(TasksResponse task in _tasks){
      if(task.status==status){
        tasks.add(task);
      }
    }
  }

  // add task screen

  void pickDate(BuildContext context)async{
    emit(const TasksStates.loadPickDate());
    DateTime? cur = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 1000))
    );
    if(cur!=null){
      date=cur.toString().removeAfterFirstSpace();
      emit(const TasksStates.successPickDate());
    }
  }

  void addTask(){
    emit(const TasksStates.loadCheckState());
    isTitle = titleController.text.isNotBlank()?false:true;
    isDescription = descController.text.isNotBlank()?false:true;
    isPriority = priority!=null?false:true;
    isDate = date!=null?false:true;
    isImage = pickedImage!=null?false:true;
    if(!isTitle&&!isDescription&&!isPriority&&!isDate&&!isImage){
      //call api
      emitAddTaskStates();
    }
    emit(const TasksStates.successCheckState());
  }

  void onBackFromAddTask(BuildContext context){
    if(titleController.text.isNotBlank()||descController.text.isNotBlank()
        ||priority!=null||date!=null||pickedImage!=null){
      WidgetFunctions.setupOnBack(
        context,
        'There are unsaved data, Do you want to leave?',
        clearData
      );
    }else{
      context.pop();
      clearData();
    }
  }

  // clear after add task
  void clearData(){
    emit(const TasksStates.loadCheckState());
    priority = date = null;
    titleController.clear();
    descController.clear();
    pickedImage = null;
    isTitle=false;
    isDescription=false;
    isPriority=false;
    isDate=false;
    isImage=false;
    emit(const TasksStates.successCheckState());
  }


  // camera screen
  CameraController? cameraController;
  late List<CameraDescription> cameras;
  bool isCameraOk=false;

  void initCamera() async{
    if(await Permission.camera.request().isGranted){
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      await cameraController!.initialize().then((value){
        cameraController!.startImageStream((image) {
          emit(const TasksStates.loadCheckState());
        });
      });
      isCameraOk=true;
      emit(const TasksStates.cameraInitialized());
    }else{
      emit(const TasksStates.cameraFailed());
    }
  }

  void captureImage() async {
    XFile image = await cameraController!.takePicture();
    pickedImage = File(image.path);
    emit(const TasksStates.capturedImage());
  }

  void pickImageFromGallery() async{
    emit(const TasksStates.loadOpenGallery());
    pickedImage = await _tasksRepository.pickImage();
    emit(const TasksStates.successOpenGallery());
  }

  void deleteImage(){
    emit(const TasksStates.loadDeleteImage());
    pickedImage=null;
    emit(const TasksStates.successDeleteImage());
  }

  void disposeCamController(BuildContext context)async{
    context.pop();
    await cameraController!.dispose();
    cameraController=null;
    isCameraOk=false;
  }


  @override
  Future<void> close() {
    cameraController?.dispose();
    return super.close();
  }

  void logout() async {
    emit(const TasksStates.loadLogout());
    final response = await _tasksRepository.logout();
    response.when(
        success: (data) async {
          if(data.success!){
            emit(const TasksStates.successLogout());
          }else{
            emit(const TasksStates.errorLogout(error: 'Something went wrong, Try again'));
          }

        },
        failure: (error){
          emit(TasksStates.errorLogout(error: error.apiErrorModel.message!));
        }
    );
  }

  void getProfile() async {
    emit(const TasksStates.loadProfile());
    final response = await _tasksRepository.getProfile();
    response.when(
        success: (data) async {
          profile = data;
          emit(const TasksStates.successProfile());
        },
        failure: (error){
          emit(TasksStates.errorProfile(error: error.apiErrorModel.message!));
        }
    );
  }

  void emitAddTaskStates() async {
    emit(const TasksStates.loadAddTask());
    ///////upload image
    String? path = await uploadImageToDatabase();
    if(path==null){
      return;
    }
    final response = await _tasksRepository.addTask(
      AddTaskBody(
        image: path,
        title: titleController.text,
        desc: descController.text,
        priority: priority,
        dueDate: date
      )
    );
    response.when(
        success: (data) async {
          emit(const TasksStates.successAddTask());
        },
        failure: (error) async {
          emit(TasksStates.errorAddTask(error: error.apiErrorModel.message!));
        }
    );
  }

  Future<String?> uploadImageToDatabase() async {
    String? path;
    final response = await _tasksRepository.uploadImage(
      await UploadImageBody(image: pickedImage!).toFormData()
    );
    response.when(
      success: (data) async {
        path =  data.image;
      },
      failure: (error) async {
        emit(TasksStates.errorAddTask(error: error.apiErrorModel.message!));
      }
    );
    return path;
  }

  void getTasksList() async {
    if(!requestMorePages)return;
    emit(const TasksStates.loadGetTasksList());
    final response = await _tasksRepository.getTasksList(page++);
    response.when(
        success: (data) async {
          if(data.isEmpty){
            requestMorePages=false;
          }else{
            for(TasksResponse task in data){
              _tasks.add(task);
            }
            checkListOfCollection();
          }
          emit(const TasksStates.successGetTasksList());
        },
        failure: (error) async {
          emit(TasksStates.errorGetTasksList(error: error.apiErrorModel.message!));
        }
    );
  }

  void getTasksAfterCRUD(){
    requestMorePages=true;
    page=1;
    tasks.clear();
    _tasks.clear();
    getTasksList();
  }

  void getQRTask(String id) async {
    emit(const TasksStates.loadGetQRTask());
    final response = await _tasksRepository.getQRTask(id);
    response.when(
        success: (data) async {
          emit(TasksStates.successGetQRTask(data));
        },
        failure: (error) async {
          emit(TasksStates.errorGetQRTask(error: error.apiErrorModel.message!));
        }
    );
  }

  void editTask(TasksResponse task) async {
    emit(const TasksStates.loadEditTask());
    final response = await _tasksRepository.editTask(
      task.id!,
      EditTaskBody(status:task.status!)
    );
    response.when(
        success: (data) async {
          emit(const TasksStates.successEditTask());
        },
        failure: (error) async {
          emit(TasksStates.errorEditTask(error: error.apiErrorModel.message!));
        }
    );
  }

  void deleteTask(String id) async {
    emit(const TasksStates.loadDeleteTask());
    final response = await _tasksRepository.deleteTask(id);
    response.when(
        success: (data) async {
          emit(const TasksStates.successDeleteTask());
        },
        failure: (error) async {
          emit(TasksStates.errorDeleteTask(error: error.apiErrorModel.message!));
        }
    );
  }

}
