import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';
import 'package:todo_task/shared/extensions.dart';

import '../../../../shared/routing/routes.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/text_styles.dart';
import '../../../../shared/widgets/horizontal_space.dart';

class AddImageCard extends StatelessWidget {
  const AddImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    TasksCubit cubit = context.read<TasksCubit>();
    return BlocBuilder<TasksCubit, TasksStates>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
                color: cubit.isImage?Colors.redAccent:ColorManager.defaultColor,
                radius: const Radius.circular(12),
                borderType: BorderType.RRect,
                dashPattern: const [1, 1],
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (bContext){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  context.pop();
                                  context.pushNamed(Routes.cameraScreen, arguments: context);
                                },
                                icon: const Icon(CupertinoIcons.camera,size: 50,),
                              )
                            ),
                            Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    context.pop();
                                    cubit.pickImageFromGallery();
                                  },
                                  icon: const Icon(Icons.image_outlined,size: 50,),
                                )
                            ),
                          ],
                        );
                      }
                    );
                    //context.pushNamed(Routes.cameraScreen, arguments: context);
                  },
                  child: Column(
                    children: [
                      if(cubit.pickedImage == null)
                        SizedBox(
                          height: 60.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svgs/add_img.svg'),
                              const HorizontalSpace(width: 8),
                              Text(
                                'Add Img',
                                style: GoogleFonts.dmSans(
                                    textStyle: TextStyles.font19Default500
                                ),
                              )
                            ],
                          ),
                        ),
                      if(cubit.pickedImage != null)
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(cubit.pickedImage!)
                                  )
                              ),

                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.deleteImage();
                                },
                                icon: const Icon(
                                  Icons.delete_forever, color: Colors.redAccent,)
                            )
                          ],
                        ),
                    ],
                  ),
                )
            ),
            if(cubit.isImage)
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                    'Upload image',
                    style: TextStyles.errorText
                ),
              ),
          ],
        );
      },
    );
  }

}