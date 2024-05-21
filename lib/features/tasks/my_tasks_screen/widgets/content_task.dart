
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/text_styles.dart';
import '../../../../shared/widgets/horizontal_space.dart';
import '../../../../shared/widgets/vertical_space.dart';

class ContentTask extends StatelessWidget{
  const ContentTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Grocery Shopping App',
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
                    color: ColorManager.lightPurple
                ),
                child: Text(
                  'Inprogress',
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyles.font12Default500
                  ),
                ),
              )
            ],
          ),
          const VerticalSpace(height: 4),
          Text(
            'This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.',
            style: GoogleFonts.dmSans(
                textStyle: TextStyles.font14DarkBlack60400
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const VerticalSpace(height: 4),
          Row(
            children: [
              SvgPicture.asset('assets/svgs/flag.svg',height: 16.h,width: 16.w,),
              const HorizontalSpace(width: 4),
              Text(
                'Medium',
                style: GoogleFonts.dmSans(
                    textStyle: TextStyles.font12Default500
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

}