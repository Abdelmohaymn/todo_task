
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/widgets/horizontal_space.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';
import '../../features/login_register/cubit/log_reg_cubit.dart';
import '../../features/login_register/cubit/log_reg_states.dart';

class DefaultTextField extends StatelessWidget{
  final bool isError;
  final String messageError, hint;
  final TextEditingController controller;
  final double? height;
  const DefaultTextField({
    super.key,
    required this.isError,
    required this.messageError,
    required this.hint,
    required this.controller,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: height??60.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isError?Colors.redAccent:ColorManager.lightGrey,
                )
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: null,
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
              ),
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
  }

}