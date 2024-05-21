
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/styles/text_styles.dart';
import '../../../../shared/widgets/vertical_space.dart';

class TextTitle extends StatelessWidget{
  final String title;
  const TextTitle({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
              textStyle: TextStyles.font12Grey400
          ),
        ),
        const VerticalSpace(height: 8),
      ],
    );
  }

}