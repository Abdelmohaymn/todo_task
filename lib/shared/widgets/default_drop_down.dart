

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';


class DefaultDropDown extends StatelessWidget{
  final bool isError;
  final List<DropdownMenuItem<String>>? items;
  final String? value;
  final String hint;
  final void Function(String?)? onChanged;
  final String? prevSvg;

  const DefaultDropDown({
    super.key,
    required this.isError,
    required this.items,
    required this.onChanged,
    required this.hint,
    this.value,
    this.prevSvg
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isError?Colors.redAccent:ColorManager.lightPurple,
              ),
              color: ColorManager.lightPurple
            ),
            child: Row(
              children: [
                if(prevSvg!=null)
                   Padding(
                     padding: EdgeInsets.only(left: 10.w),
                     child: SvgPicture.asset('assets/svgs/${prevSvg!}.svg',),
                   ),
                Expanded(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      isExpanded: true,
                      focusColor: ColorManager.lightPurple,
                      value: value,
                      items: items,
                      onChanged: onChanged,
                      hint: Text(
                        hint,
                        style: GoogleFonts.dmSans(
                          textStyle: TextStyles.font16Default700
                        ),
                      ),
                      icon: SvgPicture.asset('assets/svgs/arrow_down_2.svg'),
                    ),
                  ),
                ),
              ],
            )
        ),
        if(isError)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
                'Select priority',
                style: TextStyles.errorText
            ),
          )
      ],
    );
  }

}