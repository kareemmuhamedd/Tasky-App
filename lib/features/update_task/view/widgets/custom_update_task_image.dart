import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/features/update_task/viewmodel/bloc/update_task_bloc.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import '../../../../shared/utils/files_picker/pick_image.dart';

class CustomUpdateTaskImageWidget extends StatelessWidget {
  const CustomUpdateTaskImageWidget({
    super.key,
    required this.task,
  });

  final TaskModel task;

  Future<void> _selectImage(BuildContext context) async {
    final bloc = context.read<UpdateTaskBloc>();
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      bloc.add(UpdateTaskImageChanged(pickedImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectImage(context);
      },
      child: BlocBuilder<UpdateTaskBloc, UpdateTaskState>(
        builder: (context, state) {
          if (state.image != null) {
            return SizedBox(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(state.image!),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 225.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightOrangeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: task.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: double.infinity,
                    height: 225.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.camera,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                          Text(
                            'Update Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
