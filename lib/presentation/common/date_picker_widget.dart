// lib/presentation/common/date_picker_widget.dart

import 'package:employee_attendance/core/utility/utility.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final String labelText;

  const DatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.labelText = 'Select Date',
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: theme.primaryColor,
                  onPrimary: Colors.white,
                  surface: theme.scaffoldBackgroundColor,
                ),
                dividerTheme: const DividerThemeData(
                  space: 0,
                  thickness: 1,
                  color: Colors.black12,
                ),
                dialogTheme:
                    const DialogThemeData(backgroundColor: Colors.white),
              ),
              child: child!,
            );
          },
          firstDate: DateTime(2019),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getFormattedDate(selectedDate),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
