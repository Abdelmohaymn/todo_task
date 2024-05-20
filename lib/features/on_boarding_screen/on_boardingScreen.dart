
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/widgets/default_button.dart';
import '../../shared/routing/routes.dart';
import '../../shared/styles/text_styles.dart';
import '../../shared/widgets/vertical_space.dart';

class OnBoardingScreen extends StatelessWidget{
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
            child: Column(
              children: [
                 Image(
                  height: 440.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: const AssetImage('assets/images/art.png'),
                ),
                const VerticalSpace(height: 16),
                Text(
                  'Task Management &\nTo-Do List',
                  style: GoogleFonts.dmSans(
                    textStyle: TextStyles.font24DarkBlack700
                  ),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpace(height: 16),
                Text(
                  'This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!',
                  style: GoogleFonts.dmSans(
                      textStyle: TextStyles.font14Grey400
                  ),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpace(height: 32),
                DefaultButton(
                  text: 'Let’s Start',
                  nextIcon: 'assets/svgs/arrow_right.svg',
                  onClick: (){
                    context.pushReplacementNamed(Routes.loginScreen);
                  }
                ),
                const VerticalSpace(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

}