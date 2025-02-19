import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const PasswordField(
      {super.key, required this.controller, required this.label});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool eye = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        obscureText: eye,
        controller: widget.controller,
        style: Theme.of(context).textTheme.bodyMedium,
        inputFormatters: [LengthLimitingTextInputFormatter(12)],
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                eye = !eye;
              });
            },
            icon: Icon(
              eye ? FontAwesomeIcons.solidEye : FontAwesomeIcons.solidEyeSlash,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.red),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter the ${widget.label.toLowerCase()}";
          }
          if (value.length < 6) {
            return "Be at least 6 characters";
          }
          return null;
        },
      ),
    );
  }
}
