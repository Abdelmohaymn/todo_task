import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_cubit.dart';
import 'package:todo_task/features/login_register/cubit/log_reg_states.dart';
import 'package:todo_task/features/login_register/data/model/phone_model.dart';
import 'package:todo_task/features/login_register/widgets/password_field.dart';
import 'package:todo_task/features/login_register/widgets/phone_field.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/routing/routes.dart';
import 'package:todo_task/shared/styles/colors.dart';
import 'package:todo_task/shared/widgets/horizontal_space.dart';

import '../../../shared/styles/text_styles.dart';
import '../../../shared/widgets/default_button.dart';
import '../../../shared/widgets/vertical_space.dart';
import '../widgets/default_text_button.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  height: 440.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/images/art.png'),
                ),
                const VerticalSpace(height: 16),
                Text(
                  'Login',
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyles.font24DarkBlack700
                  ),
                ),
                const VerticalSpace(height: 16),
                const PhoneField(),
                const VerticalSpace(height: 20),
                const PasswordField(),
                const VerticalSpace(height: 20),
                DefaultButton(
                    text: 'Sign In',
                    onClick: () {
                      context.read<LogRegCubit>().loginUser();
                    }
                ),
                const VerticalSpace(height: 24),
                DefaultTextButton(
                  text1: 'Don’t have an account? ',
                  text2: 'Sign Up here',
                  onClick: (){
                    context.pushNamed(Routes.registerScreen,arguments: context);
                    context.read<LogRegCubit>().clearData();
                  },
                ),
                const VerticalSpace(height: 20),
              ],
            ),
          ),
        ),
      )
    );
  }

}