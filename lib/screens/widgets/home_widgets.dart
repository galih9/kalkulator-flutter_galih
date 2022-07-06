import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderDisplayer extends StatelessWidget {
  final String value;
  final Color color;
  final Color colorLabel;
  final String label;
  const HeaderDisplayer({
    Key? key,
    required this.value,
    required this.color,
    required this.colorLabel,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.4,
          color: colorLabel,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          color: color,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 20,
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
  const CalculatorButtons({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.btnStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: btnStyle,
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
