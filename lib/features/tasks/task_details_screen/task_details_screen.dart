
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/tasks_response.dart';
import 'package:todo_task/features/tasks/task_details_screen/widgets/task_details_bloc_listener.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/styles/colors.dart';
import 'package:todo_task/shared/widgets/default_drop_down.dart';
import 'package:todo_task/shared/widgets/vertical_space.dart';

import '../../../shared/network/remote/api_constants.dart';
import '../../../shared/styles/text_styles.dart';
import '../../../shared/widgets/svg_button.dart';
import '../cubit/tasks_cubit.dart';

class TaskDetailsScreen extends StatelessWidget{
  final TasksResponse task;
  const TaskDetailsScreen({super.key,required this.task});

  @override
  Widget build(BuildContext context) {

    TasksCubit cubit = context.read<TasksCubit>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: SvgButton(
            svg: 'arrow_left', onClick: () {
          cubit.onBackFromAddTask(context);
        }),
        title: Text(
          'Task Details',
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font16DarkBlack700
          ),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value){
              if(value=='Edit'){
                cubit.editTask(task);
              }else{
                cubit.deleteTask(task.id!);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Edit',
                  child: Text(
                    'Edit',
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyles.font16DarkBlack2500
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Delete',
                  child: Text(
                    'Delete',
                    style: GoogleFonts.dmSans(
                        textStyle: TextStyles.font16DarkBlack2500.copyWith(color: ColorManager.orange)
                    ),
                  ),
                ),
              ];
            },
            icon: SvgPicture.asset('assets/svgs/dots.svg'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image:NetworkImage('${ApiConstants.apiBaseUrl}/images/${task.image!}'),
                    )
                ),
              ),
              const VerticalSpace(height: 10),
              Text(
                task.title!,
                style: GoogleFonts.dmSans(
                  textStyle: TextStyles.font24DarkBlack700
                ),
              ),
              const VerticalSpace(height: 5),
              Text(
                task.desc!,
                style: GoogleFonts.dmSans(
                    textStyle: TextStyles.font14DarkBlack60400
                ),
              ),
              const VerticalSpace(height: 16),
              DefaultDropDown(
                isError: false,
                items: cubit.taskStatus,
                onChanged:(value){
                  task.status = value;
                },
                hint: task.status!.capitalizeFirstLetter()
              ),
              const VerticalSpace(height: 16),
              DefaultDropDown(
                  isError: false,
                  items: cubit.priorities,
                  onChanged:(value){
                    task.priority = value;
                  },
                hint: '${task.priority!.capitalizeFirstLetter()} Priority',
                  prevSvg: 'flag',
              ),
              const VerticalSpace(height: 16),
              Center(
                child: QrImageView(
                  data: task.id!,
                  version: QrVersions.auto,
                  size: 325.w,
                  gapless: false,
                ),
              ),
              const VerticalSpace(height: 20),
              const TaskDetailsBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

}