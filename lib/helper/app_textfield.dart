import 'package:flutter/material.dart';


class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.label,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.inputType = TextInputType.none,
    this.required = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;
  final bool isPassword, readOnly, required;
  final FormFieldValidator? validator;
  final TextInputType inputType;
  final int? maxLines;
  final VoidCallback? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key('${widget.label}${DateTime.now().microsecondsSinceEpoch}'),
      onTap: widget.onTap,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      autofocus: false,
      keyboardType: widget.inputType,
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        isDense: true,
        label: Text("${widget.label} ${widget.required ? "*" : ""}"),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          }
        )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
