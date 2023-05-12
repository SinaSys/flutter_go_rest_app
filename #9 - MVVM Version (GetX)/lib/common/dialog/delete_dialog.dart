import 'package:flutter/material.dart';

Future<dynamic> deleteDialog(BuildContext context) {
  Future<dynamic> dialog = showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_rounded, color: Colors.redAccent, size: 40),
            SizedBox(width: 10),
            Text("Warning", textAlign: TextAlign.center),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Are you sure you want to delete this user?"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("No"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text("Yes"),
                )
              ],
            )
          ],
        ),
      );
    },
  );

  return dialog.then((res) => res ?? false);
}
