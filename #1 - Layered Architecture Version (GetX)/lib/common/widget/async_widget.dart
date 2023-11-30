import 'package:flutter/material.dart';
import 'package:layered_architecture/common/dialog/retry_dialog.dart';
import 'package:layered_architecture/common/dialog/progress_dialog.dart';
import 'package:layered_architecture/common/controller/base_controller.dart';

class AsyncWidget extends StatelessWidget {
  const AsyncWidget({
    super.key,
    required this.apiState,
    required this.progressStatusTitle,
    required this.failureStatusTitle,
    required this.successStatusTitle,
    required this.onRetryPressed,
    required this.onSuccessPressed,
  });

  final ApiState apiState;
  final String progressStatusTitle;
  final String failureStatusTitle;
  final String successStatusTitle;
  final VoidCallback onRetryPressed;
  final VoidCallback onSuccessPressed;

  @override
  Widget build(BuildContext context) {
    return switch (apiState) {
      ApiState.loading => ProgressDialog(
          title: progressStatusTitle,
          isProgressed: true,
        ),
      ApiState.failure => RetryDialog(
          title: failureStatusTitle,
          onRetryPressed: onRetryPressed,
        ),
      ApiState.success => ProgressDialog(
          title: successStatusTitle,
          onPressed: onSuccessPressed,
          isProgressed: false,
        ),
    };
  }
}
