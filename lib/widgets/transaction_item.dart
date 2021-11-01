import 'dart:math';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required ThemeData theme,
    @required this.sign,
    @required this.transaction,
    @required this.deleteTransaction,
    this.index
  }) : _theme = theme, super(key: key);

  final ThemeData _theme;
  final String sign;
  final Transaction transaction;
  final Function deleteTransaction;
  final int index;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  double _bgColorOpacity;

  @override
  void initState() {
    // List<Color> colorsList = [
    //   Colors.grey,
    //   Colors.black,
    //   Colors.black26,
    //   Colors.white38
    // ];
    //
    // _bgColor = colorsList[Random().nextInt(colorsList.length)];
    _bgColorOpacity = Random().nextDouble();
    if(_bgColorOpacity < 0.5)
      _bgColorOpacity = _bgColorOpacity + 0.3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bgColor = Theme.of(context).primaryColorDark.withOpacity(_bgColorOpacity);
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Container(
                    // width: 90,
                    height: 60,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(10),
                      // color: widget._theme.primaryColorDark,
                      color: _bgColor,
                      // borderRadius:
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(21.0),
                      child: FittedBox(
                        child: Text(
                          '${widget.sign} ${widget.transaction.amount.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 20,
                              // color: _theme.primaryColor,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.transaction.title,
                        // style: _theme.textTheme.headline6,
                      ),
                      Text(
                        DateFormat.yMMMd()
                            .format(widget.transaction.date),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                widget.deleteTransaction(widget.transaction);
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor.withOpacity(0.8),
              ))
        ],
      ),
    );
  }
}