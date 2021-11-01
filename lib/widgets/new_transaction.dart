import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../widgets/adaptive_filled_button.dart';
import '../widgets/adaptive_flat_button.dart';
import '../widgets/adaptive_text_field.dart';

import 'package:intl/intl.dart';

import 'conditional_widget.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  final double padding;

  NewTransaction({@required this.addTx, this.padding}){
    print('Constructor NewTransaction');
  }

  @override
  _NewTransactionState createState(){
    print('createState NewTransaction');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime datePicked = DateTime.now();
  bool _isIncomeInput = false;
  bool _isExpenseInput = false;

  _NewTransactionState(){
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    super.initState();
    print('initState NewTransaction');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget NewTransaction');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose NewTransaction');
    super.dispose();
  }

  void _submitData() {
    if (_titleController.text.isEmpty) {
      Navigator.of(context).pop();
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount =
    _amountController != null ? double.parse(_amountController.text) : 0;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || datePicked == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, datePicked,
        _isIncomeInput && !_isExpenseInput);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        datePicked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build NewTransaction');
    var _isAndroid = false || Platform.isIOS;
    var _theme = Theme.of(context);
    var _mediaQuery = MediaQuery.of(context);
    var _isPortrait = _mediaQuery.orientation == Orientation.portrait;
    return LayoutBuilder(builder: (ctx, constraint) {
      double maxHeight = constraint.maxHeight;
      maxHeight = _isPortrait
          ? (maxHeight - widget.padding) * 0.5
          : maxHeight - widget.padding;
      double maxWidth = constraint.maxWidth;
      return ConditionalParentWidget(
        condition: !_isPortrait,
        conditionalBuilder: (Widget child) =>
            SingleChildScrollView(child: child),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Container(
            padding: EdgeInsets.only(
                top: (maxHeight * 0.005905),
                bottom: maxHeight * 0.005905 + _mediaQuery.viewInsets.bottom,
                right: maxWidth * 0.05,
                left: maxWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: widget.padding,
                ),
                Container(
                  height: maxHeight * 0.13,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.cancel_outlined)),
                ),
                Center(
                    child: Container(
                      height: maxHeight * 0.12,
                      child: FittedBox(
                        child: Text("Add a transaction",
                            style: _theme.textTheme.headline6
                          // .copyWith(fontSize: 35),
                        ),
                      ),
                    )),
                Container(
                  height: maxHeight * 0.12,
                  padding: EdgeInsets.only(
                    top: maxHeight * 0.02,
                  ),
                  child: AdaptiveTextField(
                    isAndroid: _isAndroid,
                    title: 'Title',
                    textController: _titleController,
                    onSubmittedFunction:  (_) {},
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  height: maxHeight * 0.12,
                  padding: EdgeInsets.only(
                    top: maxHeight * 0.02,
                  ),
                  child: AdaptiveTextField(
                    isAndroid: _isAndroid,
                    title: 'Amount',
                    textController: _amountController,
                    onSubmittedFunction:  _submitData,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: maxHeight * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: maxHeight * 0.06,
                        // width: maxWidth *0.15,
                        child: FittedBox(
                          child: Text(datePicked != null
                              ? DateFormat.yMMMd().format(datePicked)
                              : "No Date chosen"),
                        ),
                      ),
                      AdaptiveFlatButton(
                        isAndroid: _isAndroid,
                        title: "Pick a date",
                        buttonHeight: maxHeight * 0.06,
                        onPressedFunction: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: maxHeight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                          onSelected: (boolResult) {
                            setState(() {
                              _isExpenseInput = false;
                              _isIncomeInput = boolResult;
                            });
                          },
                          labelPadding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          label: const Text("Income"),
                          selected: _isIncomeInput),
                      ChoiceChip(
                          onSelected: (boolResult) {
                            setState(() {
                              _isIncomeInput = false;
                              _isExpenseInput = boolResult;
                            });
                          },
                          labelPadding:
                          const EdgeInsets.symmetric(horizontal: 8.0),
                          label: const Text("Expenses"),
                          selected: _isExpenseInput),
                    ],
                  ),
                ),
                Padding(
                  // height: maxHeight * 0.25,
                    padding: EdgeInsets.only(top: maxHeight * 0.04819),
                    child: AdaptiveFilledButton(
                      theme: _theme,
                      title: 'Add Transaction',
                      onPressedFunction: _submitData,
                      isAndroid: _isAndroid,
                      buttonHeight: maxHeight * 0.07,
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }
}
