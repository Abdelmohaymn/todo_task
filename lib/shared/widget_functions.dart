
import 'package:flutter/material.dart';
import 'package:todo_task/shared/extensions.dart';
import 'package:todo_task/shared/styles/text_styles.dart';

class WidgetFunctions{

  static setupErrorState(BuildContext context, String error){
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font16BlackRegular,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Ok',
              style: TextStyles.font14Default700,
            ),
          ),
        ],
      ),
    );
  }

  static setupLoadingState(BuildContext context){
    showDialog(
      barrierDismissible:false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static setupOnBack(BuildContext context, String message, Function() onBack){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 32,
        ),
        title: Text(
          'Attention',
          style: TextStyles.font24DarkBlack700,
        ),
        content: Text(
          message,
          style: TextStyles.font16BlackRegular,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Cancel',
              style: TextStyles.font14Default700,
            ),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              context.pop();
              onBack();
            },
            child: Text(
              'Yes',
              style: TextStyles.font14Default700,
            ),
          ),
        ],
      ),
    );
  }

  static showSuccessSnackBar(BuildContext context,String msg){
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Center(
            child: Text(
              msg,
              style: TextStyles.font16White700,
            ),
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          duration: const Duration(milliseconds: 1000),
        )
    );
  }

}