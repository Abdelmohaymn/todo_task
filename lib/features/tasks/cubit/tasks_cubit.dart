
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/features/tasks/data/tasks_repository.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/styles/text_styles.dart';

import '../../../shared/widget_functions.dart';

class TasksCubit extends Cubit<TasksStates> {

  final TasksRepository _tasksRepository;
  TasksCubit(this._tasksRepository) : super(const TasksStates.initial());

  List<String> collections=['All', 'Inprogress', 'Waiting', 'Finished'];
  int chosenCollection=0;

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
  String? priority, date;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // validation
  bool isTitle=false;
  bool isDescription=false;
  bool isPriority=false;
  bool isDate=false;



  void changeCollection(int index){
    emit(const TasksStates.loadChangeCollection());
    chosenCollection = index;
    emit(const TasksStates.successChangeCollection());
  }

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
    if(!isTitle&&!isDescription&&!isPriority&&!isDate){
      //call api
    }
    emit(const TasksStates.successCheckState());
  }

  void onBackFromAddTask(BuildContext context){
    if(titleController.text.isNotBlank()||descController.text.isNotBlank()
        ||priority!=null||date!=null){
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
  void clearData(){
    emit(const TasksStates.loadCheckState());
    priority = date = null;
    titleController.clear();
    descController.clear();
    isTitle=false;
    isDescription=false;
    isPriority=false;
    isDate=false;
    emit(const TasksStates.successCheckState());
  }

 /* void emitLoginStates() async {
    emit(const LogRegStates.loadLoginUser());
    final response = await _logRegRepo.login(
      LoginBody(
        phone: chosenCountry.getDialCode()+phoneController.text,
        password: passController.text
      )
    );
    response.when(
        success: (data){
          emit(const LogRegStates.successLoginUser());
        },
        failure: (error){
          emit(LogRegStates.errorLoginUser(error: error.apiErrorModel.message!));
        }
    );
  }*/



}
