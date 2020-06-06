import 'package:flutter/material.dart';

class SignFormField extends StatefulWidget {
  final FormFieldValidator<String> validator;
  final String label;
  final TextInputType keyboard;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final VoidCallback onEdititingComplete;
  final double fontSize;
  final Key key;
  const SignFormField({
    this.key,
    this.validator,
    @required this.label,
    this.keyboard,
    this.obscureText = false,
    this.onChanged,
    this.fontSize = 15,
    this.onEdititingComplete,
  });

  @override
  _SignFormFieldState createState() => _SignFormFieldState();
}

class _SignFormFieldState extends State<SignFormField> {
  bool _obscureText;

  // Toggles the password show status
  void _toggle() {
    if (widget.obscureText)
      setState(() {
        _obscureText = !_obscureText;
      });
  }

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    const radius = const BorderRadius.all(
      const Radius.circular(15.0),
    );
    return TextFormField(
      key: widget.key,
      
      onEditingComplete: widget.onEdititingComplete ?? () => null,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ? _obscureText : false,
      keyboardType: widget.keyboard ?? TextInputType.text,
      style: TextStyle(fontSize: widget.fontSize),
      decoration: InputDecoration(
        suffixIcon: (widget.obscureText) ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
            // size: 10,
          ),
          onPressed: () {
            _toggle();
          },
        ) : null,
        hintText: widget.label ?? "Nom",
        labelText: widget.label ?? "Nom",
        // isDense: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
      validator: widget.validator ??
          (value) {
            if (value.isEmpty) {
              return "Champ requis";
            }
            return null;
          },
    );
  }
}
