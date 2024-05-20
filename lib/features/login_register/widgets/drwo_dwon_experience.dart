
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';
import '../cubit/log_reg_cubit.dart';
import '../cubit/log_reg_states.dart';

class DropDownExperience extends StatelessWidget{
  const DropDownExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogRegCubit, LogRegStates>(
      builder: (context, state) {
        LogRegCubit cubit = context.read<LogRegCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 60.h,
                //padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: cubit.isExperience2?Colors.redAccent:ColorManager.lightGrey,
                  )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          isExpanded: true,
                          focusColor: Colors.white,
                          value: cubit.exp,
                          items: cubit.levels,
                          onChanged: (value){
                            cubit.changeExpLevel(value!);
                          },
                          hint: const Text('Choose experience level'),
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyles.font14LightBlack500
                          ),
                          icon: SvgPicture.asset('assets/svgs/drop_down.svg'),
                        ),
                      ),
                    ),
                  ],
                )
            ),
            if(cubit.isExperience2)
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                    'Choose your level',
                    style: TextStyles.errorText
                ),
              )
          ],
        );
      },
    );
  }

}