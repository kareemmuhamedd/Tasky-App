import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/typography/app_text_styles.dart';
import '../../../../shared/utils/files_picker/pick_image.dart';

class CustomTaskAddImageWidget extends StatefulWidget {
  const CustomTaskAddImageWidget({super.key});

  @override
  State<CustomTaskAddImageWidget> createState() => _CustomTaskAddImageWidgetState();
}

class _CustomTaskAddImageWidgetState extends State<CustomTaskAddImageWidget> {
  File? selectedImage;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectImage,
      child: selectedImage != null
          ? SizedBox(
        height: 300,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            selectedImage!,
            fit: BoxFit.cover,
          ),
        ),
      )
          : DottedBorder(
        color: AppColors.primaryColor,
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        dashPattern: const [3, 3],
        child: SizedBox(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.galleryIcon),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Add Image',
                style:
                AppTextStyles.font19WeightMedium.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


