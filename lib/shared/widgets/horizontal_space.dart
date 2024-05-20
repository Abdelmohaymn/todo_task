
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalSpace extends StatelessWidget{
  final double width;
  const HorizontalSpace({super.key,required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
    );
  }

}