import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TaskQRCode extends StatelessWidget {
  const TaskQRCode({
    super.key,
    required this.taskId,
  });

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 16,
      ),
      child: PrettyQrView.data(data: taskId),
    );
  }
}
