
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';


class DefaultButton extends StatelessWidget{

  final String text;
  final Function() onClick;
  final Color? color;
  final double? width;
  final double? height;
  final double? radius;
  final double? horizontalPadding;
  final TextStyle? textStyle;
  final String? nextIcon;

  const DefaultButton({
    super.key,
    required this.text,
    required this.onClick,
    this.color,
    this.width,
    this.height,
    this.horizontalPadding,
    this.radius,
    this.textStyle,
    this.nextIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height??60.h,
      width: width,
      child: FilledButton.tonal(
        onPressed: onClick,
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: horizontalPadding??5.w)),
          backgroundColor: WidgetStatePropertyAll<Color>(color??ColorManager.defaultColor),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius??12))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,style: textStyle??TextStyles.font19White700),
            if(nextIcon!=null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(
                  '$nextIcon',
                  width: 24,
                  height: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

}
