import 'package:flutter/material.dart';
import 'package:layered_architecture_cubit/core/app_extension.dart';

class PopupMenu<T> extends StatelessWidget {
  const PopupMenu({
    super.key,
    required this.items,
    required this.onChanged,
    this.icon = Icons.more_vert,
  });

  final List<T> items;
  final ValueChanged<T> onChanged;
  final IconData? icon;

  String checkType(T item) {
    if (item.isEnum) return item.getEnumString;
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      icon: Icon(icon),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      onSelected: (T item) {
        onChanged(item);
      },
      itemBuilder: (BuildContext context) {
        return items
            .map(
              (T item) => PopupMenuItem<T>(
                value: item,
                child: InkWell(
                  child: Text(checkType(item)),
                ),
              ),
            )
            .toList();
      },
    );
  }
}
