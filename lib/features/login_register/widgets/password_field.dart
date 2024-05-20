
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/widgets/horizontal_space.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';
import '../cubit/log_reg_cubit.dart';
import '../cubit/log_reg_states.dart';

class PasswordField extends StatelessWidget{
  const PasswordField({super.key});

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
              padding: EdgeInsets.only(left: 15.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: cubit.isPass?Colors.redAccent:ColorManager.lightGrey,
                  )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cubit.passController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: cubit.isPassVisible,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.dmSans(
                              textStyle: TextStyles.font14LightGrey400
                          )
                      ),
                    ),
                  ),
                  const HorizontalSpace(width: 5),
                  TextButton(
                    onPressed: (){
                      cubit.changePassVisibility();
                    },
                    child: Icon(
                      color: ColorManager.lightGrey,
                      cubit.isPassVisible?Icons.visibility_off_outlined:Icons.visibility_outlined
                    )
                  )
                ],
              )
            ),
            if(cubit.isPass)
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  'Password must not be empty',
                  style: TextStyles.errorText
                ),
              )
          ],
        );
      },
    );
  }

}