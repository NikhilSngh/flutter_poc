import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

 const AppTextButton({super.key, required this.title, this.onPressed, this.textColor, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {

    return TextButton(onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor
          )
        )
    );
  }
}

class AppElevatedButton extends StatelessWidget {
   final String title;
   final VoidCallback? onPressed;

  const AppElevatedButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed,
            child: Text(title)
        )
    );
  }
}