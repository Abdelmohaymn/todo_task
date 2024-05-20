
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';

class DefaultTextButton extends StatelessWidget{
  final String text1,text2;
  final Function() onClick;

  const DefaultTextButton({
    super.key,
    required this.text1,
    required this.text2,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font14LightGrey1400
          ),
        ),
        TextButton(
          onPressed: onClick,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size(50.w, 20.h),
            foregroundColor: ColorManager.defaultColor,
          ),
          child: Text(
            text2,
            style: GoogleFonts.dmSans(
                textStyle: TextStyles.font14Default700.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: ColorManager.defaultColor
                )
            ),
          ),
        )
      ],
    );
  }

}