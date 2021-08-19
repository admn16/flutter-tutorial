import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/grouped_transaction.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<GroupedTransaction> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        var currTx = recentTransactions[i];
        if (currTx.date.day == weekDay.day &&
            currTx.date.month == weekDay.month &&
            currTx.date.year == weekDay.year) {
          totalSum += currTx.amount;
        }
      }

      return GroupedTransaction(
          day: DateFormat.E().format(weekDay).substring(0, 1),
          amount: totalSum);
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            // return Text('${data.day}: ${data.amount}');
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data.day, data.amount,
                  totalSpending == 0.0 ? 0.0 : data.amount / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
