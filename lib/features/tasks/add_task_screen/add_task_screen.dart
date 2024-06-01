import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/login_register/widgets/drwo_dwon_experience.dart';
import 'package:todo_task/features/tasks/add_task_screen/widgets/add_tasks_bloc_listener.dart';
import 'package:todo_task/features/tasks/add_task_screen/widgets/pick_date.dart';
import 'package:todo_task/features/tasks/add_task_screen/widgets/text_title.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/routing/routes.dart';
import 'package:todo_task/shared/styles/colors.dart';
import 'package:todo_task/shared/styles/text_styles.dart';
import 'package:todo_task/shared/widget_functions.dart';
import 'package:todo_task/shared/widgets/default_button.dart';
import 'package:todo_task/shared/widgets/default_drop_down.dart';
import 'package:todo_task/shared/widgets/default_text_field.dart';
import 'package:todo_task/shared/widgets/horizontal_space.dart';
import 'package:todo_task/shared/widgets/svg_button.dart';
import 'package:todo_task/shared/widgets/vertical_space.dart';

import 'widgets/add_image_card.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TasksCubit cubit = context.read<TasksCubit>();
    return BlocBuilder<TasksCubit, TasksStates>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (v){
            if(v)return;
            cubit.onBackFromAddTask(context);
          },
          child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              titleSpacing: 0,
              leading: SvgButton(
                svg: 'arrow_left', onClick: () {
                cubit.onBackFromAddTask(context);
              }),
              title: Text(
                'Add new task',
                style: GoogleFonts.dmSans(
                    textStyle: TextStyles.font16DarkBlack700
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AddImageCard(),
                    const VerticalSpace(height: 20),
                    const TextTitle(title: 'Task title',),
                    DefaultTextField(
                      isError: cubit.isTitle,
                      messageError: 'Enter a title',
                      hint: 'Enter title here...',
                      controller: cubit.titleController
                    ),
                    const VerticalSpace(height: 20),
                    const TextTitle(title: 'Task Description',),
                    DefaultTextField(
                      isError: cubit.isDescription,
                      messageError: 'Enter a description',
                      hint: 'Enter description here...',
                      controller: cubit.descController,
                      height: 170.h,
                    ),
                    const VerticalSpace(height: 20),
                    const TextTitle(title: 'Priority',),
                    DefaultDropDown(
                      isError: cubit.isPriority,
                      items: cubit.priorities,
                      value: cubit.priority,
                      hint: 'Select priority',
                      prevSvg: 'flag',
                      onChanged: (value){
                        cubit.priority=value;
                      }
                    ),
                    const VerticalSpace(height: 20),
                    const TextTitle(title: 'Due date',),
                    const PickDate(),
                    const VerticalSpace(height: 30),
                    DefaultButton(
                      text: 'Add task',
                      textStyle: GoogleFonts.dmSans(
                        textStyle: TextStyles.font19White700
                      ),
                      onClick: (){
                        cubit.addTask();
                      }
                    ),
                    const VerticalSpace(height: 30),
                    const AddTasksBlocListener()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}