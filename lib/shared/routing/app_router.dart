

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/login_screen/login_screen.dart';
import 'package:todo_task/features/on_boarding_screen/on_boardingScreen.dart';
import 'package:todo_task/features/tasks/add_task_screen/add_task_screen.dart';
import 'package:todo_task/features/tasks/camera_screen/camera_screen.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/data/tasks_repository.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/tasks_response.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/tasks_screen.dart';
import 'package:todo_task/features/tasks/task_details_screen/task_details_screen.dart';
import 'package:todo_task/shared/di/dependency_injection.dart';
import 'package:todo_task/shared/routing/routes.dart';

import '../../features/login_register/register_screen/register_screen.dart';
import '../../features/profile_screen/profile_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen()
      );
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<LogRegCubit>()..getPhonesCode(),
              child: const LoginScreen()
            )
      );
      case Routes.registerScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<LogRegCubit>(settings.arguments as BuildContext),
              child: const RegisterScreen(),
            )
      );
      case Routes.profileScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<TasksCubit>(settings.arguments as BuildContext)..getProfile(),
                child: const ProfileScreen()
            )
        );
      case Routes.tasksScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => getIt<TasksCubit>()..getTasksList(),
              child: const TasksScreen()
            )
        );
      case Routes.addTasksScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<TasksCubit>(settings.arguments as BuildContext),
                child: const AddTaskScreen()
            )
        );
      case Routes.taskDetailsScreen:
        Map<String,dynamic>? args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<TasksCubit>(args!['context'] as BuildContext),
                child: TaskDetailsScreen(task: args['task'] as TasksResponse,)
            )
        );
      case Routes.cameraScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: BlocProvider.of<TasksCubit>(settings.arguments as BuildContext)..initCamera(),
                child: const CameraScreen()
            )
        );
      default :
        SystemNavigator.pop();
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text(
                      'No route defined for ${settings.name}'
                  ),
                ),
              ),
        );
    }
  }
}