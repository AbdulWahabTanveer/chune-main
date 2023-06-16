
import 'package:flutter/material.dart';

class buttomSheetHeader extends StatelessWidget {
  const buttomSheetHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
      height: 5,
      width: 50,
    );
  }
}

class HeightSpace extends StatelessWidget {
  final double height;

  const HeightSpace([this.height]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 10,
    );
  }
}



class MText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final int maxLines;

  const MText(
    this.text, {
    Key key,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      maxLines: maxLines,
    );
  }
}
