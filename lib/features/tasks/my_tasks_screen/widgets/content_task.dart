
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/models/tasks_response.dart';

import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/text_styles.dart';
import '../../../../shared/widgets/horizontal_space.dart';
import '../../../../shared/widgets/vertical_space.dart';
import '../../cubit/tasks_cubit.dart';

class ContentTask extends StatelessWidget{
  final int index;
  const ContentTask({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    TasksResponse task = context.read<TasksCubit>().tasks[index];

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title!,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyles.font16DarkBlack700
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 6.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: statusBackgroundColor(task.status!)
                ),
                child: Text(
                  task.status!,
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyles.font12Default500.copyWith(
                        color: statusColor(task.status!)
                      )
                  ),
                ),
              )
            ],
          ),
          const VerticalSpace(height: 4),
          Text(
            task.desc!,
            style: GoogleFonts.dmSans(
                textStyle: TextStyles.font14DarkBlack60400
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const VerticalSpace(height: 4),
          Row(
            children: [
              SvgPicture.asset('assets/svgs/flag.svg',height: 16.h,width: 16.w,color: priorityColor(task.priority!),),
              const HorizontalSpace(width: 4),
              Text(
                task.priority!,
                style: GoogleFonts.dmSans(
                    textStyle: TextStyles.font12Default500.copyWith(
                      color: priorityColor(task.priority!)
                    )
                ),
              ),
              const Spacer(),
              Text(
                '30/12/2022',
                style: GoogleFonts.dmSans(
                    textStyle: TextStyles.font12DarkBlack60400
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Color priorityColor(String priority){
    if(priority=='low') {
      return ColorManager.blue;
    } else if(priority =='medium') {
      return ColorManager.defaultColor;
    }
    return ColorManager.orange;
  }

  Color statusColor(String status){
    if(status=='waiting') {
      return ColorManager.orange;
    } else if(status =='inProgress') {
      return ColorManager.defaultColor;
    }
    return ColorManager.blue;
  }

  Color statusBackgroundColor(String status){
    if(status=='waiting') {
      return ColorManager.lightOrange;
    } else if(status =='inProgress') {
      return ColorManager.lightPurple;
    }
    return ColorManager.lightBlue;
  }

}