import 'package:flutter/material.dart';

class RetryDialog extends StatelessWidget {
  const RetryDialog({
    super.key,
    required this.title,
    required this.onRetryPressed,
  });

  final String title;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.redAccent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      title: const Row(
        children: [
          Icon(Icons.warning, color: Colors.redAccent),
          SizedBox(width: 15),
          Text("Error")
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: onRetryPressed,
                child: const Text("Retry"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
