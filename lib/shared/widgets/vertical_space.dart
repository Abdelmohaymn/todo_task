
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpace extends StatelessWidget{
  final double height;
  const VerticalSpace({
    super.key,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:height.h,);
  }

}