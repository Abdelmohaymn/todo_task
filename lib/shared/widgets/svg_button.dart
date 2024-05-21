
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgButton extends StatelessWidget{
  final String svg;
  final Function() onClick;
  const SvgButton({
    super.key,
    required this.svg,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onClick,
      icon: SvgPicture.asset('assets/svgs/$svg.svg'),
    );
  }

}