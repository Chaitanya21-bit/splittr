import 'package:flutter/material.dart';
import 'package:splitter/providers/category_provider.dart';
import 'package:splitter/utils/get_provider.dart';

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = getProvider<CategoryProvider>(context,listen: true);
    final categories = categoryProvider.categories;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        hintText: 'Select a category',
        labelText: 'Category'
      ),
      value: categoryProvider.selectedCategory,
      onChanged: categoryProvider.setCategory,
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

