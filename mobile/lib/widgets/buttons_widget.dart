import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  Widget child;
  VoidCallback onPressed;
  bool?
  left; // false - turn rounded corners right | true - turn rounded corners left
  EdgeInsetsGeometry buttonPadding;
  double cornerRound = 0;
  Color? backgroundColor;
  Color? effectColor;

  IconButtonWidget({
    required this.child,
    required this.onPressed,
    this.effectColor,
    this.backgroundColor,
    this.left,
    this.buttonPadding = EdgeInsetsGeometry.zero,
    this.cornerRound = 20,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return IconButton(
      padding: buttonPadding,
      // splashColor: Colors.red,
      highlightColor: effectColor,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : theme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: left == null
                ? Radius.circular(cornerRound)
                : (left == true ? Radius.zero : Radius.circular(cornerRound)),
            bottomRight: left == null
                ? Radius.circular(cornerRound)
                : (left == true ? Radius.zero : Radius.circular(cornerRound)),
            bottomLeft: left == null
                ? Radius.circular(cornerRound)
                : (left == true ? Radius.circular(cornerRound) : Radius.zero),
            topLeft: left == null
                ? Radius.circular(cornerRound)
                : (left == true ? Radius.circular(cornerRound) : Radius.zero),
          ),
        ),
      ),
      onPressed: onPressed,
      icon: child,
    );
  }
}
