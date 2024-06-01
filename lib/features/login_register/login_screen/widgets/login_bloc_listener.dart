
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_states.dart';
import 'package:todo_task/features/login_register/login_screen/model/login_response.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/network/local/shared_pref_helper.dart';
import 'package:todo_task/shared/routing/routes.dart';
import 'package:todo_task/shared/widget_functions.dart';

import '../../../../shared/network/local/shared_pred_constants.dart';

class LoginBlocListener extends StatelessWidget{
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogRegCubit,LogRegStates>(
      listenWhen: (context,state) => state is LoadLoginUser || state is SuccessLoginUser || state is ErrorLoginUser,
      listener: (context,state){
        state.whenOrNull(
          loadLoginUser: (){
            WidgetFunctions.setupLoadingState(context);
          },
          successLoginUser: (data){
            context.pop();
            context.pushNamedAndRemoveUntil(Routes.tasksScreen, predicate: (Route<dynamic> route) { return false; },);
          },
          errorLoginUser: (error){
            WidgetFunctions.setupErrorState(context, error);
          }
        );
      },
      child: const SizedBox.shrink(),
    );
  }

}