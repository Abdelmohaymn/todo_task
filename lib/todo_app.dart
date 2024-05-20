
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/shared/routing/app_router.dart';

class TodoApp extends StatelessWidget{
  final String initialRoute;
  final AppRouter appRouter;

  const TodoApp({
    super.key,
    required this.appRouter,
    required this.initialRoute
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));
    return ScreenUtilInit(
        designSize: const Size(375,812),
        minTextAdapt: true,
        builder: (_,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            initialRoute: initialRoute,
            onGenerateRoute: appRouter.generateRoute,
          );
        }
    );
  }

}