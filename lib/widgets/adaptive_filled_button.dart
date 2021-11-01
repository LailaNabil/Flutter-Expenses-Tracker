import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFilledButton extends StatelessWidget {
  final bool isAndroid;
  final Function onPressedFunction;
  final double buttonHeight;
  final String title;
  final ThemeData theme;

  const AdaptiveFilledButton(
      {this.isAndroid,
        this.onPressedFunction,
        this.buttonHeight,
        this.title,
        this.theme});

  @override
  Widget build(BuildContext context) {
    return isAndroid
        ? TextButton(
      onPressed: onPressedFunction,
      child: Container(
        height: buttonHeight,
        child: FittedBox(
          child: Text(
            title,
            // style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: MaterialStateProperty.all(
              theme.primaryColorDark.withOpacity(0.8))),
    )
        : CupertinoButton.filled(
      onPressed: onPressedFunction,
      child: Container(
        height: buttonHeight,
        child: FittedBox(
          child: Text(
            title,
            // style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.all(8.0),
    );
  }
}
