import 'package:flutter/foundation.dart';

class CategoryProvider extends ChangeNotifier {
  final List<String> _categories = [
    'Food',
    'Travel',
    'Taxi',
    'Settle',
    'Other',
  ];

  List<String> get categories => _categories;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  setCategory(String? newCategory){
    _selectedCategory = newCategory;
    notifyListeners();
  }

}