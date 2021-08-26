import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet',
                    style: Theme.of(context).textTheme.title,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      // NOTE: Keys are only useful for mapping stateful widgets
                      key: ValueKey(tx.id),
                      deleteTx: deleteTx,
                      transaction: tx,
                    ))
                .toList());

    // : ListView.builder(
    //     itemBuilder: (ctx, index) {
    //       var transaction = transactions[index];

    //       return TransactionItem(
    //         transaction: transaction,
    //         deleteTx: deleteTx,
    //         // key: transaction.id as Key,
    //       );
    //     },
    //     itemCount: transactions.length,
    //   );
  }
}
