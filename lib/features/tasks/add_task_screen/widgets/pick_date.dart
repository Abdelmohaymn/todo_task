import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';

import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/text_styles.dart';

class PickDate extends StatelessWidget {
  const PickDate({super.key});


  @override
  Widget build(BuildContext context) {
    TasksCubit cubit = context.read<TasksCubit>();
    return BlocBuilder<TasksCubit, TasksStates>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                cubit.pickDate(context);
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: cubit.isDate ? Colors.redAccent : ColorManager
                            .lightGrey,
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                              cubit.date ?? 'choose due date...',
                              style: GoogleFonts.dmSans(
                                  textStyle: cubit.date != null ? TextStyles
                                      .font16DarkBlack700 : TextStyles
                                      .font14LightGrey400
                              )
                          )
                      ),
                      SvgPicture.asset('assets/svgs/calendar.svg')
                    ],
                  )
              ),
            ),
            if(cubit.isDate)
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                    'Select date',
                    style: TextStyles.errorText
                ),
              )
          ],
        );
      },
    );
  }
}