import 'package:flutter/material.dart';

class ColumnForm extends StatelessWidget {
  ///To validate the form
  final GlobalKey<FormState> formKey;

  final List<Widget> children;
  const ColumnForm({@required this.formKey, @required this.children});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: IntrinsicWidth(
        child: Column(
          children: children ?? [SizedBox.expand()],
        ),
      ),
    );
  }
}
