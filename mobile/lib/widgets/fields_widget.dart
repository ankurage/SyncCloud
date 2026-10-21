import 'package:flutter/material.dart';

class MultiTextFielBackgrounddWidget extends StatelessWidget {
  Widget child;
  Widget suffixIcon;
  Widget prefixIcon;
  VoidCallback? onPressedSuffix;
  VoidCallback? onPressedPrefix;
  bool? left; // false - turn rounded corners right | true - turn rounded corners left
  EdgeInsetsGeometry buttonPadding;
  EdgeInsetsGeometry childPadding;
  double cornerRound = 0;

  MultiTextFielBackgrounddWidget({
    required this.child,
    this.suffixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    this.onPressedSuffix,
    this.onPressedPrefix,
    this.left,
    this.buttonPadding = EdgeInsetsGeometry.zero,
    this.childPadding = EdgeInsetsGeometry.zero,
    this.cornerRound = 20
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      margin: EdgeInsetsGeometry.zero,
      color: theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(cornerRound))
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          prefixIcon == SizedBox
          ? SizedBox()
          : IconButton(
            padding: buttonPadding,
            style: IconButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(cornerRound))
              )
            ),
            onPressed: onPressedPrefix,
            icon: prefixIcon,
          ),
          Padding(
            padding: childPadding,
            child: child,
          ),
          suffixIcon == SizedBox
          ? SizedBox()
          : IconButton(
            padding: buttonPadding,
            style: IconButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(cornerRound))
              )
            ),
            onPressed: onPressedSuffix,
            icon: suffixIcon,
          ),
        ],
      ),
    );
  }
}

class DoubleTextFieldBackgrounddWidget extends StatelessWidget {
  Widget fieldOne;
  Widget fieldTwo;
  EdgeInsetsGeometry childPadding;
  double cornerRound = 0;

  DoubleTextFieldBackgrounddWidget({
    required this.fieldOne,
    required this.fieldTwo,
    this.childPadding = EdgeInsetsGeometry.zero,
    this.cornerRound = 20
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      margin: EdgeInsetsGeometry.zero,
      color: theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(cornerRound))
      ),
      child: SizedBox(
        height: 80,
        child: OverflowBox(
          child: Row(
            spacing: 20,
            mainAxisAlignment: .center,
            children: [
              fieldOne,
              VerticalDivider(),
              fieldTwo,
            ],
          ),
        ),
      ),
    );
  }
}

class SingleTextFieldBackgroundWidget extends StatelessWidget {
  Widget child;
  // bool? left; // false - turn rounded corners right | true - turn rounded corners left
  EdgeInsetsGeometry childPadding;
  double cornerRound = 0;

  SingleTextFieldBackgroundWidget({
    required this.child,
    this.childPadding = EdgeInsetsGeometry.zero,
    this.cornerRound = 20
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      margin: EdgeInsetsGeometry.zero,
      color: theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(cornerRound))
      ),
      child: Padding(
        padding: childPadding,
        child: child,
      ),
    );
  }
}
