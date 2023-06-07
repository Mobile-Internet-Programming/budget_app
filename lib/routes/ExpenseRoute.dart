import 'package:budget_app/modules/Transaction.dart';
import 'package:budget_app/modules/TransactionModel.dart';
import 'package:budget_app/screens/TransactionScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpanseRoute extends StatelessWidget {
  const ExpanseRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var transaction = context.watch<TransactionModel>();

    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: transaction.expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return TransactionScreen(text: transaction.expenses[index].text, amount: transaction.expenses[index].amount);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.transparent),
    );
  }

}