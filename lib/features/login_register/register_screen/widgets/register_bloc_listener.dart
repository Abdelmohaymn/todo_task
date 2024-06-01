
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_states.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/widget_functions.dart';

class RegisterBlocListener extends StatelessWidget{
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogRegCubit,LogRegStates>(
      listenWhen: (context,state) => state is LoadRegisterUser || state is SuccessRegisterUser || state is ErrorRegisterUser,
      listener: (context,state){
        state.whenOrNull(
          loadRegisterUser: (){
            WidgetFunctions.setupLoadingState(context);
          },
          successRegisterUser: (data){
            context.pop();
            // move to home
          },
          errorRegisterUser: (error){
            WidgetFunctions.setupErrorState(context, error);
          }
        );
      },
      child: const SizedBox.shrink(),
    );
  }

}