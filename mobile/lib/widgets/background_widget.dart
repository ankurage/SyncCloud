import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  List<Widget> childrens;

  BackgroundWidget({
    this.childrens = const []
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor.withAlpha(100),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
        ),
        child: Stack(
          fit: .expand,
          children: childrens,
        ),
      ),
    );
  }
}

class BackScreenIconWidget extends StatelessWidget {
  const BackScreenIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_outlined)
    );
  }
}
