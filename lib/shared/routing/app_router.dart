

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/login_screen/login_screen.dart';
import 'package:todo_task/features/on_boarding_screen/on_boardingScreen.dart';
import 'package:todo_task/shared/di/dependency_injection.dart';
import 'package:todo_task/shared/routing/routes.dart';

import '../../features/login_register/register_screen/register_screen.dart';

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