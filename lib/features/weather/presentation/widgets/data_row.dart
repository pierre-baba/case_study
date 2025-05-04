import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DataSpanText extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback? onPressed;
  final TextStyle? style1;
  final TextStyle? style2;
  final bool reverse;
  final TextAlign textAlign;

  const DataSpanText(
      {Key? key,
      required this.text1,
      required this.text2,
      this.textAlign = TextAlign.center,
      this.onPressed,
      this.style1,
      this.style2,
      this.reverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle text1Style = TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
    );
    TextStyle text2Style = TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.none,
    );

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: reverse ? "$text2:" : text1,
        style: style1 ?? (reverse ? text1Style : text2Style),
        children: <InlineSpan>[
          TextSpan(
            text: reverse ? ' $text1' : ': $text2',
            recognizer: TapGestureRecognizer()..onTap = onPressed,
            style: style2 ?? (reverse ? text2Style : text1Style),
          ),
        ],
      ),
    );
  }
}
