import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/profile_screen/widgets/information_card.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';

import '../../shared/styles/text_styles.dart';
import '../../shared/widgets/svg_button.dart';
import '../tasks/cubit/tasks_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          'Profile',
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font16DarkBlack700
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: BlocBuilder<TasksCubit, TasksStates>(
                builder: (context, state) {
                  if(state is LoadProfile){
                    return const Center(child: CircularProgressIndicator());
                  }else if(state is ErrorProfile){
                    return Center(child: Text(state.error));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        InformationCard(
                          title: 'Name',
                          content: cubit.profile!.displayName!,
                        ),
                        InformationCard(
                          title: 'Phone',
                          content: cubit.profile!.username!,
                          icon:'copy_icon'
                        ),
                        InformationCard(
                          title: 'Level',
                          content: cubit.profile!.level!,
                        ),
                        InformationCard(
                          title: 'Years of experience',
                          content: cubit.profile!.experienceYears!.toString(),
                        ),
                        InformationCard(
                          title: 'Location',
                          content: cubit.profile!.address!,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}