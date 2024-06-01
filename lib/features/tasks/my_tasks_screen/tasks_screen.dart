import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/widgets/collection_item.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/widgets/my_tasks_bloc_listener.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/widgets/task_item.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/routing/routes.dart';
import 'package:todo_task/shared/styles/colors.dart';
import 'package:todo_task/shared/styles/text_styles.dart';
import 'package:todo_task/shared/widgets/horizontal_space.dart';
import 'package:todo_task/shared/widgets/vertical_space.dart';

import '../../../shared/widgets/svg_button.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint("Last item is visible!");
        context.read<TasksCubit>().getTasksList();
      }
    });
  }

  Future<void> scanQR() async {
    String? barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB$barcodeScanRes');
    } on PlatformException {
      //print('ERROR');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if(barcodeScanRes!=null){
        context.read<TasksCubit>().getQRTask(barcodeScanRes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TasksCubit cubit = context.read<TasksCubit>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            'Tasky',
            style: GoogleFonts.dmSans(
                textStyle: TextStyles.font24DarkBlack700
            ),
          ),
        ),
        actions: [
          SvgButton(svg: 'profile_icon', onClick: () {context.pushNamed(Routes.profileScreen,arguments: context);},),
          BlocBuilder<TasksCubit, TasksStates>(
            builder: (context, state) {
              if(state is LoadLogout){
                return const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator()
                  ),
                );
              }
              return SvgButton(svg: 'logout', onClick: () {
                cubit.logout();
              },);
            },
          ),
          const HorizontalSpace(width: 5),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Tasks',
              style: GoogleFonts.dmSans(
                  textStyle: TextStyles.font16DarkBlack60700
              ),
            ),
            const VerticalSpace(height: 20),
            SizedBox(
              height: 50.h,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CollectionItem(index: index);
                  },
                  separatorBuilder: (context, index) =>
                  const HorizontalSpace(width: 8),
                  itemCount: 4
              ),
            ),
            const VerticalSpace(height: 12),
            Expanded(
              child: BlocBuilder<TasksCubit, TasksStates>(
                builder: (context, state) {
                  if (state is LoadGetTasksList && cubit.tasks.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (cubit.tasks.isEmpty) {
                    return const Center(child: Text('You have no tasks here'),);
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async{
                            cubit.getTasksAfterCRUD();
                          },
                          child: ListView.builder(
                            //controller: _scrollController,
                            itemBuilder: (context, index) {
                              return TaskItem(index: index);
                            },
                            itemCount: cubit.tasks.length,
                            physics: const BouncingScrollPhysics(),
                          ),
                        ),
                      ),
                      if(state is LoadGetTasksList)
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Center(child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),),
                        )
                    ],
                  );
                },
              ),
            ),
            const MyTasksBlocListener(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                scanQR();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              backgroundColor: ColorManager.lightPurple2,
              child: SvgPicture.asset('assets/svgs/qr_code.svg'),
            ),
          ),
          const VerticalSpace(height: 10),
          SizedBox(
            width: 64,
            height: 64,
            child: FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                context.pushNamed(Routes.addTasksScreen, arguments: context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              backgroundColor: ColorManager.defaultColor,
              child: SvgPicture.asset('assets/svgs/plus_icon.svg'),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}