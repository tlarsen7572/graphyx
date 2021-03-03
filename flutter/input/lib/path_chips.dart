import 'package:flutter/material.dart';
import 'package:input/bloc.dart';
import 'package:input/configuration.dart' as c;
import 'package:input/field_state.dart';

class PathChips extends StatelessWidget {
  PathChips(this.field, this.index);
  final c.FieldData field;
  final int index;

  Widget build(BuildContext context) {
    var fieldState = BlocProvider.of<FieldState>(context);
    return StreamBuilder(
      stream: fieldState.pathChanged,
      builder: (_, __){
        List<Widget> widgets = [];
        if (field.Path != null) {
          var pathIndex = 0;
          for (var container in field.Path) {
            widgets.add(ElementChip('${container.Element.Key} (${container.Element.DataType})', pathIndex));
            pathIndex++;
          }
        }
        return Wrap(
          spacing: 4,
          runSpacing: 4,
          children: widgets,
        );
      },
    );
  }
}

class ElementChip extends StatelessWidget {
  ElementChip(this.label, this.index);
  final String label;
  final int index;

  Widget build(BuildContext context) {
    var fieldState = BlocProvider.of<FieldState>(context);
    return Chip(
        label: Text(label),
        deleteIcon: Icon(Icons.close),
        onDeleted: () {
          fieldState.truncatePathAtElement(index);
        }
    );
  }
}