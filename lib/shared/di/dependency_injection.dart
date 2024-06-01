

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/data/repository.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/data/tasks_repository.dart';

import '../network/remote/api_service.dart';
import '../network/remote/dio_helper.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async{

  //dio & api
  Dio dio = DioHelper.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));


  // login - register
  getIt.registerLazySingleton<LogRegRepository>(() => LogRegRepository(getIt()));
  getIt.registerFactory<LogRegCubit>(() => LogRegCubit(getIt()));

  // tasks
  getIt.registerLazySingleton<TasksRepository>(() => TasksRepository(getIt(),ImagePicker()));
  getIt.registerFactory<TasksCubit>(() => TasksCubit(getIt()));




}