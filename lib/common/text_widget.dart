import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  const TextWidget(
      {super.key,
      required this.text,
      this.size,
      this.fontWeight,
      this.fontFamily,
      this.decoration,
      this.color,
      this.align,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 20,
      textAlign: align,
      softWrap: true,
      style: TextStyle(
        fontSize: size ?? 16,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        decoration: decoration,
        overflow: overflow,
        color: color ?? Colors.black,
      ),
    );
  }
}
