import 'package:flutter/material.dart';

class DropDown<T> extends StatelessWidget {
  DropDown({this.items, this.onChanged, this.hint, this.value});
  final List<DropdownMenuItem<T>> items;
  final Widget hint;
  final Function(T) onChanged;
  final T value;

  Widget build(BuildContext context) {
    return DropdownButton<T>(items: items, onChanged: onChanged, hint: hint, value: value);
  }
}