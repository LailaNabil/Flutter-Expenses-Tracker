import 'package:flutter/material.dart';

class ChartBar extends StatefulWidget {
  final double part;
  final double total;
  final String title;

  const ChartBar({Key key, this.part, this.total, this.title})
      : super(key: key);

  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  double get percent {
    double percentVal;
    (widget.part <= widget.total && widget.total != 0)
        ? percentVal = widget.part / widget.total
        : percentVal = 0.0;
    return percentVal;
  }

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    return LayoutBuilder(builder: (ctx, constraint) {
      double maxHeight = constraint.maxHeight;
      double maxWidth = constraint.maxWidth;
      // double chartBarHeight = 80;
      double chartBarHeight = maxHeight * 0.60606;
      return Padding(
        // padding: const EdgeInsets.all(4.0),
        padding: EdgeInsets.symmetric(
            vertical: maxHeight * 0.0303, horizontal: maxWidth * 0.10178),
        child: Column(
          children: [
            Container(
              // height: 20,
              height: maxHeight * 0.1515,
              child: FittedBox(
                child: Text("${(widget.part).toStringAsFixed(1)}"),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: maxHeight * 0.0303,
                  horizontal: maxWidth * 0.10178),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.part > widget.total
                          ? Colors.red
                          : _theme.primaryColor,
                    ),
                    // width: 15,
                    width: maxWidth * 0.38168,
                    height: chartBarHeight * percent,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _theme.primaryColor.withOpacity(0.15),
                    ),
                    // width: 15,
                    width: maxWidth * 0.3186,
                    height: chartBarHeight,
                  )
                ],
              ),
            ),
            Container(
                height: maxHeight * 0.12124,
                child: FittedBox(child: Text(widget.title)))
          ],
        ),
      );
    });
  }
}