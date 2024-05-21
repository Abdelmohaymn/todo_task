
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/widgets/collection_item.dart';
import 'package:todo_task/features/tasks/my_tasks_screen/widgets/task_item.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/routing/routes.dart';
import 'package:todo_task/shared/styles/colors.dart';
import 'package:todo_task/shared/styles/text_styles.dart';
import 'package:todo_task/shared/widgets/horizontal_space.dart';
import 'package:todo_task/shared/widgets/vertical_space.dart';

import '../../../shared/widgets/svg_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          SvgButton(svg:'profile_icon',onClick: () {  },),
          SvgButton(svg:'logout',onClick: () {  },),
          const HorizontalSpace(width: 5),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
        child: Column(
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
                itemBuilder: (context,index){
                  return CollectionItem(index: index);
                },
                separatorBuilder: (context,index)=>const HorizontalSpace(width: 8),
                itemCount: 4
              ),
            ),
            const VerticalSpace(height: 12),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return const TaskItem();
                },
                itemCount: 9,
                physics: const BouncingScrollPhysics(),
              )
            ),
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
              onPressed: (){

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
              onPressed: (){
                context.pushNamed(Routes.addTasksScreen,arguments: context);
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