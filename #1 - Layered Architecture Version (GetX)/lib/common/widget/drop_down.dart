import 'package:flutter/material.dart';
import 'package:layered_architecture/core/app_extension.dart';

class DropDown<T> extends StatefulWidget {
  const DropDown({
    super.key,
    required this.onChanged,
    required this.items,
    this.initialItem,
  });

  final ValueChanged<T> onChanged;
  final List<T> items;
  final T? initialItem;

  @override
  State<DropDown> createState() => _DropDownState<T>();
}

class _DropDownState<T> extends State<DropDown<T>> {
  T? selectedItem;

  String checkType(T item) {
    if (item.isEnum) return item.getEnumString;
    return item.toString();
  }

  @override
  void initState() {
    if (widget.initialItem != null) {
      selectedItem = widget.initialItem;
    } else {
      selectedItem = widget.items.first;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        onChanged: (T? currentItem) {
          widget.onChanged(currentItem as T);
          setState(() => selectedItem = currentItem);
        },
        items: widget.items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  checkType(item),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
