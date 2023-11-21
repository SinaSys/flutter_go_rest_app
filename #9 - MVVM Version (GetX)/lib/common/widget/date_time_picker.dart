import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    super.key,
    required this.selectedDateTime,
    this.dateTime,
  });

  final void Function(DateTime date) selectedDateTime;
  final DateTime? dateTime;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime date;

  @override
  void initState() {
    if (widget.dateTime == null) {
      date = DateTime.now();
    } else {
      date = widget.dateTime!;
    }
    super.initState();
  } //Get date from date picker

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
        builder: (_, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      surface: Colors.amber,
                      primary: const Color(0xFFF4511E),
                    ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.selected)
                            ? const Color(0xFFF4511E)
                            : Colors.black87),
                  ),
                ),
              ),
              child: child!);
        },
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 1));
  }

  //Set the date that is taken from the user by date picker
  void setDate(DateTime? newDate) {
    if (newDate == null) return;

    date = DateTime(
        newDate.year, newDate.month, newDate.day, date.hour, date.minute);

    widget.selectedDateTime(date);
  }

  //Get time from date picker
  Future<TimeOfDay?> pickTime() async {
    return await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: date.hour, minute: date.minute));
  }

  //Set the time that is taken from the user by time picker
  void setTime(TimeOfDay? newTime) {
    if (newTime == null) return;
    date =
        DateTime(date.year, date.month, date.day, newTime.hour, newTime.minute);
    widget.selectedDateTime(date);
  }

  @override
  Widget build(BuildContext context) {
    final hours = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              DateTime? newDate = await pickDate();
              setDate(newDate);
              setState(() {});
            },
            child: Text(
              "${date.year} / ${date.month} / ${date.day}",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          ),
          const SizedBox(width: 15),
          TextButton(
            onPressed: () async {
              TimeOfDay? newTime = await pickTime();
              setTime(newTime);
              setState(() {});
            },
            child: Text(
              "$hours : $minute",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
          )
        ],
      ),
    );
  }
}
