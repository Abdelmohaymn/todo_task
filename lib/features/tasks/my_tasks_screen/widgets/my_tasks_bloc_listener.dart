
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/tasks_response.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/network/local/secure_storage/secure_storage_helper.dart';
import 'package:todo_task/shared/network/local/shared_pred_constants.dart';
import 'package:todo_task/shared/network/local/shared_pref_helper.dart';
import 'package:todo_task/shared/routing/routes.dart';
import 'package:todo_task/shared/widget_functions.dart';

class MyTasksBlocListener extends StatelessWidget{
  const MyTasksBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksCubit,TasksStates>(
      listenWhen: (context,state) => state is SuccessLogout || state is LoadGetQRTask
      || state is SuccessGetQRTask || state is ErrorGetQRTask,
      listener: (context,state){
        state.whenOrNull(
          successLogout: (){
            SecureStorageHelper.removeData(key: SharedPrefConstants.tokenKey);
            SecureStorageHelper.removeData(key: SharedPrefConstants.refreshTokenKey);
            context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (Route<dynamic> route) { return false; });
          },
          loadGetQRTask: (){
            WidgetFunctions.setupLoadingState(context);
          },
          successGetQRTask: (data){
            context.pop();
            context.pushNamed(Routes.taskDetailsScreen,arguments: {'context':context,'task':data as TasksResponse});
          },
          errorGetQRTask: (error){
            WidgetFunctions.setupErrorState(context, error);
          }
        );
      },
      child: const SizedBox.shrink(),
    );
  }

}