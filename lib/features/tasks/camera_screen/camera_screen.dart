import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/features/tasks/cubit/tasks_cubit.dart';
import 'package:todo_task/features/tasks/cubit/tasks_states.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TasksCubit cubit = context.read<TasksCubit>();
    return PopScope(
      canPop: false,
      onPopInvoked: (v){
        if(v)return;
        cubit.disposeCamController(context);
      },
      child: Scaffold(
        body: BlocBuilder<TasksCubit, TasksStates>(
          builder: (context, state) {
            if(cubit.isCameraOk==false){
              return const SizedBox.shrink();
            }
            return Stack(
              children: [
                Transform.scale(
                  scale: 1 / (cubit.cameraController!.value.aspectRatio * MediaQuery.of(context).size.aspectRatio),
                  alignment: Alignment.topCenter,
                  child: CameraPreview(
                    cubit.cameraController!,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: (){
                      cubit.captureImage();
                    },
                    icon: const Icon(
                      Icons.camera,
                      size: 50,
                      color: Colors.white,
                    )
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}