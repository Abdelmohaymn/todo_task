
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/network/remote/api_constants.dart';
import 'package:todo_task/shared/routing/routes.dart';

import '../../../../shared/widgets/horizontal_space.dart';
import '../../../../shared/widgets/vertical_space.dart';
import '../../cubit/tasks_cubit.dart';
import 'content_task.dart';

class TaskItem extends StatelessWidget{
  final int index;
  const TaskItem({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    TasksCubit cubit = context.read<TasksCubit>();

    return InkWell(
      onTap: (){
        context.pushNamed(Routes.taskDetailsScreen,arguments: {'context':context,'task':cubit.tasks[index]});
      },
      child: Container(
        width: double.infinity,
        height: 110.h,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image(
                width: 64.w,
                height: 64.h,
                fit: BoxFit.cover,
                image:NetworkImage('${ApiConstants.apiBaseUrl}/images/${cubit.tasks[index].image!}'),
              ),
            ),
            const HorizontalSpace(width: 10),
            ContentTask(index:index),
            const HorizontalSpace(width: 10),
            SvgPicture.asset('assets/svgs/dots.svg')
          ],
        ),
      ),
    );
  }

}