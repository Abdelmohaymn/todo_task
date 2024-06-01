import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/styles/text_styles.dart';
import 'package:todo_task/shared/widgets/svg_button.dart';
import 'package:todo_task/shared/widgets/vertical_space.dart';
import '../../../shared/styles/colors.dart';

class InformationCard extends StatelessWidget {
  final String title, content;
  final String? icon;

  const InformationCard({
    super.key,
    required this.title,
    required this.content,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ColorManager.lightGrey4,
            ),
            color: ColorManager.lightGrey4,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyles.font12LightBlack40500,
                      ),
                    ),
                    const VerticalSpace(height: 4),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 200.h, // Set a max height for the content
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          content,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyles.font18LightBlack60700,
                          ),
                          maxLines: null, // Allow the text to have unlimited lines
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (icon != null)
                SvgButton(
                  svg: icon!,
                  onClick: () {
                    Clipboard.setData(ClipboardData(text: content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Text copied to clipboard'),
                        duration: Duration(milliseconds: 800),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
        const VerticalSpace(height: 20),
      ],
    );
  }
}
