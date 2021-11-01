import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  double get totalWeeklySpent {
    double total = 0;
    recentTransactions.forEach((element) {
      if (!element.income) {
        total = total + element.amount;
      }
    });
    return total;
  }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      recentTransactions.forEach((element) {
        if (element.date.day == weekday.day &&
            element.date.month == weekday.month &&
            element.date.year == weekday.year &&
            !element.income) {
          totalSum = totalSum + element.amount;
        }
      });
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum.abs(),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build charts");
    var _theme = Theme.of(context);
    return LayoutBuilder(builder: (ctx, constraint) {
      double maxHeight = constraint.maxHeight;
      double maxWidth = constraint.maxWidth;
      return Padding(
        // padding: const EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(
            horizontal: 10.0, vertical: maxHeight * 0.0439),
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: maxHeight * 0.0659, horizontal: 5.0),
              child: Column(
                children: [
                  Padding(
                    // padding: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.symmetric(vertical: maxHeight * 0.035),
                    child: Container(
                      // height: maxHeight * 0.0878,
                      height: maxHeight * 0.095,
                      child: FittedBox(
                        child: Text(
                          "Weekly expenses chart",
                          style: _theme.textTheme.headline6
                          // .copyWith(fontSize: 16)
                          ,
                        ),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: groupedTransactionValues.reversed
                          .map((e) => Container(
                        // width: 40,
                        width: maxWidth * 0.1,
                        // height: maxHeight * 0.8024,
                        height: maxHeight * 0.57,
                        child:
                        ChartBar(
                          title: e['day'],
                          part: e['amount'],
                          total: totalWeeklySpent,
                        ),
                      ))
                          .toList()),
                ],
              )),
        ),
      );
    });
  }
}
