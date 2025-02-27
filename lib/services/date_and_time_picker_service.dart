import 'package:flutter/material.dart';

class DateAndTimePickerService {
  // date time picker
  Future<String?> selectDateTime(
    BuildContext context,
  ) async {
    // Show date picker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Show time picker
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDateTime =
            "${"${combinedDateTime.toLocal()}".split(' ')[0]} ${pickedTime.format(context)}";

        return formattedDateTime;
      }
    }
  }
}
