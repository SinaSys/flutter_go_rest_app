import 'package:flutter/material.dart';
import 'package:clean_architecture_cubit/core/app_style.dart';
import 'package:clean_architecture_cubit/core/app_asset.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAsset.emptyState),
          Text(message, style: headLine1),
        ],
      ),
    );
  }
}
