import 'package:flutter/material.dart';

import '../../core/app_asset.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAsset.emptyState),
          Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
