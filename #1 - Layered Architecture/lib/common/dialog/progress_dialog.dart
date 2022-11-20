import 'package:flutter/material.dart';

import '../widget/spinkit_indicator.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({
    Key? key,
    required this.title,
    required this.isProgressed,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final bool isProgressed;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // shape: const RoundedRectangleBorder(
      //   side: BorderSide(color: Color(0xFFF4511E), width: 1.0),
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(15.0),
      //   ),
      // ),
      title: const Text("Please wait"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const SizedBox(height: 15),
          isProgressed
              ? const SpinKitIndicator(type: SpinKitType.circle)
              : const SizedBox(),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: isProgressed
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: onPressed,
                    child: const Text("Success"),
                  ),
          )
        ],
      ),
    );
  }
}
