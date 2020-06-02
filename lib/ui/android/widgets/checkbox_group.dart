import 'package:flutter/material.dart';
import 'package:kult/core/utils.dart';
import 'package:kult/data/models/member.dart';
import 'package:kult/domain/entities/choice_list.dart';
import 'package:kult/domain/entities/member.dart';
import 'package:kult/ui/android/widgets/checkboxKult.dart';

class CheckboxGroup<T> extends StatefulWidget {
  final ChoiceList groupChoice;
  final Axis direction;
  // final List<T> children;
  final bool Function() ableToRegister;
  final bool alert;

  final Member Function() model;

  const CheckboxGroup({
    Key key,
    this.groupChoice = ChoiceList.SAMEDI1,
    @required this.direction,
    // @required this.children,
    @required this.model,
    this.ableToRegister,
    this.alert = false,
  }) : super(key: key);

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  ChoiceList _groupValue = ChoiceList.SAMEDI1;

  @override
  void initState() {
    // TODO: implement initState
    _groupValue = widget.groupChoice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model();
    final ableToRegister = checkFunction(widget.ableToRegister);
    return Flex(
      direction: widget.direction,
      children: ChoiceList.values
          .map(
            (e) => CheckboxKult(
              choice: e,
              model: model,
              ableToRegister: ableToRegister,
              alert: widget.alert,
              enabled: _groupValue == e,
              onPressed: () {
                setState(() {
                  if (_groupValue != e) _groupValue = e;
                });
              },
            ),
          )
          .toList(),
    );
  }
}
