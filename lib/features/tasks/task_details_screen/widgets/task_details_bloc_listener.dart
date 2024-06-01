
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_states.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/widget_functions.dart';

class TaskDetailsBlocListener extends StatelessWidget{
  const TaskDetailsBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksCubit,TasksStates>(
      listenWhen: (context,state) => state is LoadEditTask || state is SuccessEditTask || state is ErrorEditTask
        || state is LoadDeleteTask || state is SuccessDeleteTask || state is ErrorDeleteTask,
      listener: (context,state){
        state.whenOrNull(
          loadEditTask: (){
            WidgetFunctions.setupLoadingState(context);
          },
          successEditTask: (){
            context.pop();
            WidgetFunctions.showSuccessSnackBar(context, 'Task edited successfully');
            context.read<TasksCubit>().getTasksAfterCRUD();
          },
          errorEditTask: (error){
            WidgetFunctions.setupErrorState(context, error);
          },
          loadDeleteTask: (){
            WidgetFunctions.setupLoadingState(context);
          },
          successDeleteTask: (){
            context.pop();
            WidgetFunctions.showSuccessSnackBar(context, 'Task deleted successfully');
            context.read<TasksCubit>().getTasksAfterCRUD();
          },
          errorDeleteTask: (error){
            WidgetFunctions.setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

}