import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_states.dart';
import 'package:todo_task/features/login_register/widgets/password_field.dart';
import 'package:todo_task/features/login_register/widgets/phone_field.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/routing/routes.dart';

import '../../../shared/styles/text_styles.dart';
import '../../../shared/widgets/default_button.dart';
import '../../../shared/widgets/vertical_space.dart';
import '../widgets/default_text_button.dart';
import '../widgets/default_text_field.dart';
import '../widgets/drwo_dwon_experience.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LogRegCubit cubit = context.read<LogRegCubit>();
    return PopScope(
      canPop: false,
      onPopInvoked: (v) {
        if (v) return;
        context.pop();
        cubit.clearData();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: BlocBuilder<LogRegCubit, LogRegStates>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          height: 300.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: const AssetImage('assets/images/art.png'),
                        ),
                        const VerticalSpace(height: 16),
                        Text(
                          'Register',
                          style: GoogleFonts.dmSans(
                              textStyle: TextStyles.font24DarkBlack700
                          ),
                        ),
                        const VerticalSpace(height: 16),
                        DefaultTextField(
                          isError: cubit.isName,
                          messageError: 'Name must not be empty',
                          hint: 'Name',
                          controller: cubit.nameController,
                        ),
                        const VerticalSpace(height: 16),
                        const PhoneField(),
                        const VerticalSpace(height: 16),
                        DefaultTextField(
                          isError: cubit.isExperience,
                          messageError: 'This field must not be empty',
                          hint: 'Years of experience',
                          controller: cubit.expController,
                        ),
                        const VerticalSpace(height: 16),
                        const DropDownExperience(),
                        const VerticalSpace(height: 16),
                        DefaultTextField(
                          isError: cubit.isAddress,
                          messageError: 'Address must not be empty',
                          hint: 'Address',
                          controller: cubit.addressController,
                        ),
                        const VerticalSpace(height: 16),
                        const PasswordField(),
                        const VerticalSpace(height: 20),
                        DefaultButton(
                            text: 'Sign up',
                            onClick: () {
                              cubit.registerUser();
                            }
                        ),
                        const VerticalSpace(height: 24),
                        DefaultTextButton(
                          text1: 'Already have an account? ',
                          text2: 'Sign in',
                          onClick: () {
                            context.pop();
                            //context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (Route<dynamic> route)=>false);
                            cubit.clearData();
                          },
                        ),
                        const VerticalSpace(height: 20)
                      ],
                    );
                  },
                ),
              ),
            ),
          )
      ),
    );
  }

}