import 'package:flutter/material.dart';

class RowForm extends StatelessWidget {
  ///To validate the form
  final GlobalKey<FormState> formKey;

  final List<Widget> children;
  const RowForm({@required this.formKey, @required this.children});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: IntrinsicHeight(
        child: Row(
          children: children ?? [SizedBox.expand()],
        ),
      ),
    );
  }
}
