import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'charts.dart';

class OverviewTransactions extends StatelessWidget {
  final ThemeData _theme;
  final double _totalBalance;
  final List<Transaction> _recentTransactions;
  final double appBarHeight;

  const OverviewTransactions({
    Key key,
    @required ThemeData theme,
    @required double totalBalance,
    @required List<Transaction> recentTransactions,
    this.appBarHeight,
  })  : _theme = theme,
        _totalBalance = totalBalance,
        _recentTransactions = recentTransactions,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      double maxHeight = constraint.maxHeight;
      // maxHeight = maxHeight -appBarHeight;
      double maxWidth = constraint.maxWidth;
      List<Widget> totalBalanceList = [
        Container(
          // height: 30,
          height: (maxHeight * 0.085),
          width: appBarHeight>0 ? maxWidth * 0.4 : maxWidth * 0.4,
          child:
          FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              "Total Balance",
              //to fix this correctly, we need to use CupertinoApp
              //because it cant follow the default
              //but keep in mind CupertinoApp is not polished yet as it has little options
              style: _theme.textTheme.headline6,
            ),
          ),
        ),
        SizedBox(
          // height: appBarHeight > 0 ? 0.0 : (maxHeight * 0.02),
          height: (maxHeight * 0.02),
        ),
        Container(
          // height: 35,
          // height: (maxHeight * 0.099),
          // height: appBarHeight > 0
          //     ? (maxHeight - appBarHeight) * 0.192
          //     : (maxHeight * 0.107),
          height: (maxHeight * 0.085),
          width: appBarHeight>0 ? maxWidth * 0.3 : maxWidth * 0.4,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              "\$ $_totalBalance",
              style: _theme.textTheme.headline6,
            ),
          ),
        ),
      ];
      return Stack(
        children: [
          Container(
            color: _theme.primaryColorLight,
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? maxHeight * 0.68
                : maxHeight,
            width: MediaQuery.of(context).orientation != Orientation.portrait
                ? maxWidth * 0.68
                : maxWidth,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: (maxHeight * 0.13),
                    left: (maxWidth * 0.05),
                    right: (maxWidth * 0.05),
                    bottom: (maxHeight * 0.01)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: appBarHeight> 0 ? 0.0 : appBarHeight,
                    // ),
                    appBarHeight > 0
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: totalBalanceList,
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: totalBalanceList,
                    )
                  ],
                ),
              ),
              Flexible(
                //it is flexible because percentages causes error of 0.25 pixel
                //which is probably due to multiplying by double values
                // height: (maxHeight * 0.558),
                  child: Chart(_recentTransactions)),
            ],
          ),
        ],
      );
    });
  }
}
