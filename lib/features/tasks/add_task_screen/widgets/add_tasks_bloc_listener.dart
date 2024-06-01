
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_states.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/widget_functions.dart';

class AddTasksBlocListener extends StatelessWidget{
  const AddTasksBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksCubit,TasksStates>(
      listenWhen: (context,state) => state is ImageCaptured || state is LoadAddTask || state is SuccessAddTask
        || state is ErrorAddTask,
      listener: (context,state){
        state.whenOrNull(
          capturedImage: (){
            context.read<TasksCubit>().disposeCamController(context);
          },
          loadAddTask: (){
            WidgetFunctions.setupLoadingState(context);
          },
          successAddTask: (){
            context.pop();
            WidgetFunctions.showSuccessSnackBar(context, 'Task added successfully');
            context.read<TasksCubit>().clearData();
            context.read<TasksCubit>().getTasksAfterCRUD();
          },
          errorAddTask: (error){
            WidgetFunctions.setupErrorState(context, error);
          }
        );
      },
      child: const SizedBox.shrink(),
    );
  }

}