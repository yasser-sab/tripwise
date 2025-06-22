import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final Widget leadingIcon;
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback onTap;

  const RoundedButton(
      {super.key,
      required this.leadingIcon,
      required this.text,
      this.width,
      this.height,
      this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width != null ? width : MediaQuery.of(context).size.width * 0.6,
      height:
          height != null ? height : MediaQuery.of(context).size.height * 0.08,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.zero,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 17),
              child: SizedBox(
                child: leadingIcon,
                width: 40,
                height: 40,
              ),
            ),
            const Spacer(),
            Text(
              text,
              style: GoogleFonts.aBeeZee(
                  fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 17),
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
