import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    print("build TransactionList");
    var _theme = Theme.of(context);
    var _mediaQuery = MediaQuery.of(context);
    var _screenHeight = _mediaQuery.size.height;
    print("_screenHeight $_screenHeight");
    // var _screenWidth = _mediaQuery.size.width;
    // var _isPortrait = _mediaQuery.orientation == Orientation.portrait;
    return Container(
      // height: _isPortrait ? _screenHeight - 360 : _screenHeight,
      // width: _isPortrait ? _screenWidth : _screenWidth / 2,
      child: transactions.length == 0
          ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "No transactions added yet!",
            style: _theme.textTheme.headline6.copyWith(
                fontWeight: FontWeight.w100, fontStyle: FontStyle.italic),
          ),
        ],
      )
          :
      ListView(
        children:
        transactions.map((tx){
          String sign;
          tx.income ? sign = "+ " : sign = "- ";
          return TransactionItem(
              key: ValueKey(tx.id),
              theme: _theme,
              sign: sign,
              transaction: tx,
              deleteTransaction: deleteTransaction);
        }).toList()
        ,
      ),
      // ListView.builder(
      //         itemBuilder: (ctx, index) {
      //           String sign;
      //           transactions[index].income ? sign = "+ " : sign = "- ";
      //           return TransactionItem(
      //               index: index,
      //               theme: _theme,
      //               sign: sign,
      //               transaction: transactions[index],
      //               deleteTransaction: deleteTransaction);
      //         },
      //         itemCount: transactions.length,
      //       ),
    );
  }
}
