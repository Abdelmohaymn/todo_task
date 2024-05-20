
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/widgets/horizontal_space.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/text_styles.dart';
import '../cubit/log_reg_cubit.dart';
import '../cubit/log_reg_states.dart';

class DefaultTextField extends StatelessWidget{
  final bool isError;
  final String messageError, hint;
  final TextEditingController controller;
  const DefaultTextField({
    super.key,
    required this.isError,
    required this.messageError,
    required this.hint,
    required this.controller,
  });

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
                    color: isError?Colors.redAccent:ColorManager.lightGrey,
                  )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hint,
                          hintStyle: GoogleFonts.dmSans(
                              textStyle: TextStyles.font14LightGrey400
                          )
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
                    messageError,
                  style: TextStyles.errorText
                ),
              )
          ],
        );
      },
    );
  }

}