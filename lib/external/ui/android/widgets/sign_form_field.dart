import 'package:flutter/material.dart';

class SignFormField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final String label;
  final TextInputType keyboard;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final double fontSize;
  const SignFormField({
    Key key,
    this.validator,
    @required this.label,
    this.keyboard,
    this.obscureText = false,
    this.onChanged,
    this.fontSize = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = const BorderRadius.all(
      const Radius.circular(15.0),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          '${label ?? "Nom"} :',
          style: TextStyle(fontSize: fontSize, color: Colors.white),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: 200,
          child: TextFormField(
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboard ?? TextInputType.text,
            style: TextStyle(fontSize: fontSize),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              fillColor: Colors.white,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(color: Color(0xFF4CA8BC), width: 2),
              ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderRadius: radius,
              //   borderSide: BorderSide(color: Color(0xFF4CA8BC), width: 2),
              // ),
              border: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(color: Color(0xFF4CA8BC), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(color: Colors.red, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: radius,
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),

              errorStyle: TextStyle(),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              errorMaxLines: 1,
            ),
            validator: validator ??
                (value) {
                  if (value.isEmpty) {
                    return "Champ requis";
                  }
                  return null;
                },
          ),
        ),
      ],
    );
  }
}
