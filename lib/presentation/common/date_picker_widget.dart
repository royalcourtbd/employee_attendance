// lib/presentation/common/date_picker_widget.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
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
              DateFormat('dd-MM-yyyy').format(selectedDate),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
