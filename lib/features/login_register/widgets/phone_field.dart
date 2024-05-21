import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_states.dart';
import 'package:todo_task/shared/widgets/vertical_space.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';
import '../../../shared/widgets/horizontal_space.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: cubit.isPhone?Colors.redAccent:ColorManager.lightGrey,
                  )
              ),
              child: Row(
                children: [
                  DropdownButton(
                    value: cubit.chosenCountry,
                    items: cubit.phonesCode.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value, // Use the current PhoneModel as the value
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeCountry(value!);
                    },
                    underline: Container(),
                    icon: SvgPicture.asset('assets/svgs/arrow_down.svg'),
                  ),
                  const HorizontalSpace(width: 10),
                  Expanded(
                    child: TextField(
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone number',
                        hintStyle: GoogleFonts.dmSans(
                            textStyle: TextStyles.font14LightGrey400
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
            if(cubit.isPhone)
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  'Enter a valid number',
                  style: TextStyles.errorText
                ),
              )
          ],
        );
      },
    );
  }

}