import 'package:flutter/foundation.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/19/24

class DateInput extends ConsumerStatefulWidget {
  final String? title;
  Function(DateTime) onSelectParam;
  DateInput({super.key, this.title, required this.onSelectParam});

  @override
  DateInputState createState() => DateInputState();
}

class DateInputState extends ConsumerState<DateInput> {

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      decoration: InputDecoration(
        labelText: widget.title,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      initialPickerDateTime:
      DateTime.now().add(const Duration(days: 20)),
      mode: DateTimeFieldPickerMode.date,
      onChanged: (DateTime? value) {
        if (kDebugMode) logger.i("selected date $value");
        setState(() {
          widget.onSelectParam(value!);
        });
      },
    );
  }
}
