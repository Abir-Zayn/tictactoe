import 'package:flutter/material.dart';

class TextHeading extends StatelessWidget {
  final TextStyle style;
  final String text;
  final int maxLine;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final bool softWrap;
  final double textScaleFactor;

  const TextHeading({
    super.key, 
    required this.style, 
    required this.text, 
    required this.maxLine,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.ellipsis,
    this.softWrap = false,
    this.textScaleFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      softWrap: softWrap,
      textAlign: textAlign,
      overflow: overflow,
      style: style,
      textScaleFactor: textScaleFactor,
    );
  }
}