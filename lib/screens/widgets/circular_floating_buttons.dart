import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Color iconColor;
  final ImageIcon icon;
  final Function onClick;
  final String msg;

  CircularButton(
      {this.color,
      this.width,
      this.height,
      this.icon,
      this.onClick,
      this.iconColor,
      this.msg});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: msg,
        textStyle: TextStyle(color: whiteColor),
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: blueColor.withOpacity(.6),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ],
          ),
          width: width,
          height: height,
          child: IconButton(
              icon: icon,
              iconSize: 35,
              enableFeedback: true,
              color: iconColor,
              onPressed: onClick),
        ));
  }
}

class CircularButton1 extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final Color color;
  final Color iconColor;
  final ImageIcon icon;
  final Function onClick;

  CircularButton1({
    this.color,
    this.width,
    this.height,
    this.icon,
    this.onClick,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: blueColor.withOpacity(.3),
              offset: Offset(0, 5),
              blurRadius: 5)
        ],
      ),
      width: width,
      height: height,
      child: IconButton(
          icon: icon,
          iconSize: iconSize != null ? iconSize : 35,
          enableFeedback: true,
          color: iconColor,
          onPressed: onClick),
    );
  }
}
