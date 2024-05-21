
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/widgets/horizontal_space.dart';
import '../../../../shared/widgets/vertical_space.dart';
import 'content_task.dart';

class TaskItem extends StatelessWidget{
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

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
              child: Container(
                width: 64.w,
                height: 64.h,
                color: Colors.black,
              ),
            ),
            const HorizontalSpace(width: 10),
            const ContentTask(),
            const HorizontalSpace(width: 10),
            SvgPicture.asset('assets/svgs/dots.svg')
          ],
        ),
      ),
    );
  }

}