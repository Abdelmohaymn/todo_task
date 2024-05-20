

import 'package:get_it/get_it.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/data/repository.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async{

  //dio & api
  //Dio dio = DioHelper.getDio();
  //getIt.registerLazySingleton<ApiService>(() => ApiService(dio));


  // login - register
  getIt.registerLazySingleton<LogRegRepository>(() => LogRegRepository());
  getIt.registerFactory<LogRegCubit>(() => LogRegCubit(getIt()));




}