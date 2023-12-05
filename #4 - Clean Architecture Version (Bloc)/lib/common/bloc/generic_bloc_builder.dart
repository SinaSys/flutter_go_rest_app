import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_bloc/common/dialog/retry_dialog.dart';
import 'package:clean_architecture_bloc/common/dialog/progress_dialog.dart';
import 'package:clean_architecture_bloc/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_bloc/common/widget/spinkit_indicator.dart';

class GenericBlocBuilder<A extends BlocBase<GenericBlocState<B>>, B> extends StatelessWidget {
  const GenericBlocBuilder({
    super.key,
    this.emptyWidget,
    this.successWidget,
    this.progressStatusTitle,
    this.successStatusTitle,
    this.onSuccessPressed,
    required this.onRetryPressed,
    this.buildWhen,
  });

  final Widget? emptyWidget;

  final VoidCallback onRetryPressed;
  final VoidCallback? onSuccessPressed;

  final String? successStatusTitle;
  final String? progressStatusTitle;

  final BlocBuilderCondition<GenericBlocState<B>>? buildWhen;

  final Widget Function(GenericBlocState<B> state)? successWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<A, GenericBlocState<B>>(
      buildWhen: buildWhen,
      builder: (BuildContext context, GenericBlocState<B> state) {
        switch (state.status) {
          case Status.empty:
            return emptyWidget ?? const SizedBox();
          case Status.loading:
            return progressStatusTitle == null
                ? const SpinKitIndicator(type: SpinKitType.circle)
                : ProgressDialog(
                    title: progressStatusTitle!,
                    isProgressed: true,
                  );
          case Status.failure:
            return RetryDialog(
              title: state.error ?? "Error",
              onRetryPressed: onRetryPressed,
            );
          case Status.success:
            return successWidget != null
                ? successWidget!(state)
                : ProgressDialog(
                    title: successStatusTitle ?? "",
                    onPressed: onSuccessPressed,
                    isProgressed: false,
                  );
        }
      },
    );
  }
}
