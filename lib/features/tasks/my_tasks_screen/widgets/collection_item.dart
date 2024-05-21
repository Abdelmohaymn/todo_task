import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';

import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/text_styles.dart';

class CollectionItem extends StatelessWidget {
  final int index;

  const CollectionItem({
    super.key,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    TasksCubit cubit = context.read<TasksCubit>();
    return BlocBuilder<TasksCubit, TasksStates>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            cubit.changeCollection(index);
          },
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: cubit.chosenCollection==index?ColorManager.defaultColor:ColorManager.lightGrey3
            ),
            child: Center(
              child: Text(
                cubit.collections[index],
                style: GoogleFonts.dmSans(
                    textStyle: cubit.chosenCollection==index?TextStyles.font16White700:TextStyles.font16lightGrey2400
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}