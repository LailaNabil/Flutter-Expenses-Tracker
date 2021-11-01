import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/transaction.dart';

import 'overview_transactions.dart';
import 'transaction_list.dart';

class PageContent extends StatelessWidget {
  double appBarHeight;
  final ThemeData theme;
  final double totalBalance;
  final List<Transaction> recentTransactions;
  final List<Transaction> userTransactions;
  final Function deleteTransaction;

  PageContent({Key key, this.appBarHeight, this.theme, this.totalBalance, this.recentTransactions, this.userTransactions, this.deleteTransaction}) : super(key: key);

  // Page({this.appBarHeight , this.theme , this.totalBalance , this.recentTransactions , this.userTransactions , this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    print("build page");
    var _mediaQuery = MediaQuery.of(context);
    var _screenHeight = _mediaQuery.size.height;
    bool _isPortrait =  _mediaQuery.orientation == Orientation.portrait;
    if(appBarHeight < Scaffold.of(context).appBarMaxHeight)
      appBarHeight = Scaffold.of(context).appBarMaxHeight;
    double _realHeight = (_screenHeight - appBarHeight - _mediaQuery.padding.top);
    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
            height: _realHeight,
            child: MainWidget(
              isColumn: _isPortrait,
              // isColumn: true,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: OverviewTransactions(
                    theme: theme,
                    totalBalance: totalBalance,
                    recentTransactions: recentTransactions,
                    appBarHeight: appBarHeight,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TransactionList(userTransactions, deleteTransaction),
                )
              ],
            ),
          )),)
    ;
  }
}

class MainWidget extends StatelessWidget {
  final bool isColumn;
  final List<Widget> children;

  MainWidget({
    @required this.isColumn,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return isColumn
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: crossAxisAlign != null ? crossAxisAlign : CrossAxisAlignment.center,
      children: children,
    );
  }
}
/**
 * import 'package:flutter/material.dart';
    import 'package:flutter/cupertino.dart';

    import '../models/transaction.dart';

    import 'overview_transactions.dart';
    import 'transaction_list.dart';

    class PageContent extends StatelessWidget {
    final double appBarHeight;
    final ThemeData theme;
    final double totalBalance;
    final List<Transaction> recentTransactions;
    final List<Transaction> userTransactions;
    final Function deleteTransaction;

    const PageContent({Key key, this.appBarHeight, this.theme, this.totalBalance, this.recentTransactions, this.userTransactions, this.deleteTransaction}) : super(key: key);

    // Page({this.appBarHeight , this.theme , this.totalBalance , this.recentTransactions , this.userTransactions , this.deleteTransaction});

    @override
    Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    var _screenHeight = _mediaQuery.size.height;
    var _screenWidth = _mediaQuery.size.width;
    bool _isPortrait =  _mediaQuery.orientation == Orientation.portrait;
    double _realHeight = (_screenHeight - appBarHeight - _mediaQuery.padding.top);
    double _sectionHeight = _isPortrait
    ? _realHeight * 0.5
    : _realHeight;
    return SafeArea(
    child: SingleChildScrollView(
    child: MainWidget(
    isColumn: _isPortrait,
    // isColumn: true,
    children: <Widget>[
    Container(
    height: _sectionHeight,
    width: _isPortrait ? _screenWidth : _screenWidth * 0.5,
    child: OverviewTransactions(
    theme: theme,
    totalBalance: totalBalance,
    recentTransactions: recentTransactions,
    appBarHeight: appBarHeight,
    ),
    // Container(color: Colors.green,)
    ),
    Container(
    height: _sectionHeight,
    width: _isPortrait ? _screenWidth : _screenWidth * 0.5,
    child: TransactionList(userTransactions, deleteTransaction)
    // Container(color: Colors.deepOrange,),
    )
    ],
    )),)
    ;
    }
    }

    class MainWidget extends StatelessWidget {
    final bool isColumn;
    final List<Widget> children;

    MainWidget({
    @required this.isColumn,
    @required this.children,
    });

    @override
    Widget build(BuildContext context) {
    return isColumn
    ? Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: children,
    )
    : Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    // crossAxisAlignment: crossAxisAlign != null ? crossAxisAlign : CrossAxisAlignment.center,
    children: children,
    );
    }
    }
 **/