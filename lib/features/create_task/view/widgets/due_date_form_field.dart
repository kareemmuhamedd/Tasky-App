import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky_app/shared/assets/icons.dart';
import 'package:tasky_app/shared/widgets/custom_text_form_field.dart';

import '../../../../shared/utils/date_picker/date_picker.dart';
import '../../viewmodel/bloc/create_task_bloc.dart';

class DueDateFormField extends StatelessWidget {
  const DueDateFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(
      builder: (context, state) {
        final selectedDate = state.selectedDueDate;

        return CustomTextFormField(
          contentPadding: const EdgeInsets.only(left: 15),
          hintText: selectedDate ?? 'Choose due date...',
          readOnly: true,
          onTap: () async {
            final bloc = context.read<CreateTaskBloc>();
            final date = await showDatePickerUtil(context);
            if (date != null) {
              bloc.add(DueDateChanged(date));
            }
          },
          suffixIcon: SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: SvgPicture.asset(
                AppIcons.calendarIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
