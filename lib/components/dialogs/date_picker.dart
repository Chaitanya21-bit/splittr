import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:splitter/services/datetime_service.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateTimeService = Provider.of<DateTimeService>(context);
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      horizontalTitleGap: 0.0,
      trailing:
      Text(DateFormat("dd-MM-yyyy").format(dateTimeService.selectedDateTime)),
      leading: const Icon(Icons.date_range),
      title: TextButton(
        onPressed: () => openDatePicker(context, dateTimeService),
        child: Text(
          'Choose Date',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  openDatePicker(BuildContext context, DateTimeService dateTimeService) {
    return showDatePicker(
        context: context,
        initialDate: dateTimeService.selectedDateTime,
        firstDate: DateTime(2021),
        lastDate: DateTime.now())
        .then((date) {
      if (date != null) {
        dateTimeService.setDateTime(date);
      }
    });
  }
}
