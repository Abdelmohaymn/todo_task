import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:todo_task/shared/di/dependency_injection.dart';
import 'package:todo_task/shared/routing/app_router.dart';
import 'package:todo_task/shared/routing/routes.dart';
import 'package:todo_task/todo_app.dart';

import 'bloc_obsrver.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserver();
  await setupGetIt();
  await init();
  //await SharedPrefHelper.init();

  String initialRoute = Routes.tasksScreen;


  runApp(TodoApp(
      appRouter: AppRouter(),
      initialRoute: initialRoute
  ));
}
