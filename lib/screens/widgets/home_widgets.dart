import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HeaderDisplayer extends StatelessWidget {
  final String value;
  final Color color;
  final Color colorLabel;
  final String label;
  final Orientation orientation;
  final double labelWidth;
  final double valueWidth;
  const HeaderDisplayer({
    Key? key,
    required this.value,
    required this.color,
    required this.colorLabel,
    required this.label,
    required this.orientation,
    required this.labelWidth,
    required this.valueWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          width: labelWidth,
          color: colorLabel,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          color: color,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          width: valueWidth,
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class CalculatorButtons extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final ButtonStyle btnStyle;
  final double fontSize;
  const CalculatorButtons({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.btnStyle,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: btnStyle,
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          color: Colors.black,
        ),
      ),
    );
  }
}
