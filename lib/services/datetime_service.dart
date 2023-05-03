import 'package:flutter/foundation.dart';

class DateTimeService extends ChangeNotifier{
  DateTime _selectedDateTime = DateTime.now();
  DateTime get selectedDateTime => _selectedDateTime;

  setDateTime(DateTime newDateTime){
    _selectedDateTime = newDateTime;
    notifyListeners();
  }
}