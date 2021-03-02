import 'package:flutter/material.dart';
import 'package:input/app_state.dart';
import 'package:input/bloc.dart';
import 'package:input/configuration.dart' as c;
import 'package:input/field_state.dart';
import 'package:input/path_chips.dart';
import 'package:input/path_selector.dart';

class FieldWidget extends StatefulWidget {
  FieldWidget(this.index) {
    this.field = c.Configuration.Fields[index];
    this.key = ObjectKey(field);
  }
  int index;
  c.Field field;
  Key key;
  State<StatefulWidget> createState() {
    return _FieldWidgetState();
  }
}

class _FieldWidgetState extends State<FieldWidget> {
  TextEditingController _name;

  initState(){
    _name = TextEditingController(text: widget.field.Name);
  }

  void _deleteField(){
    c.Configuration.Fields.removeAt(widget.index);
    BlocProvider.of<AppState>(context).notifyUpdated(updated.Fields);
  }

  Widget build(BuildContext context) {
    return BlocProvider<FieldState>(
      bloc: FieldState(widget.field),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(icon: Icon(Icons.delete), onPressed: _deleteField),
              SizedBox(
                width: 200,
                child: TextField(controller: _name, onChanged: (value){
                  widget.field.Name = value;
                }),
              ),
              Expanded(child: PathChips(widget.field, widget.index)),
            ],
          ),
          PathSelector(widget.field),
        ],
      ),
    );
  }
}
