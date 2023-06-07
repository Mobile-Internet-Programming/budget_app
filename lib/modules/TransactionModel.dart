import 'dart:collection';

import 'package:budget_app/modules/Transaction.dart';
import 'package:budget_app/modules/TransactionTypes.dart';
import 'package:flutter/cupertino.dart';

class TransactionModel extends ChangeNotifier {
  final List<Transaction> _transactionList = [];

  UnmodifiableListView<Transaction> get transactions => UnmodifiableListView(_transactionList.reversed);

  UnmodifiableListView<Transaction> get incomes {
    List<Transaction> filteredList = [];

    for(Transaction t in _transactionList) {
      if(t.transactionType == TransactionTypes.INCOME) {
        filteredList.add(t);
      }
    }

    return UnmodifiableListView(filteredList.reversed);
  }

  UnmodifiableListView<Transaction> get expenses {
    List<Transaction> filteredList = [];

    for(Transaction t in _transactionList) {
      if(t.transactionType == TransactionTypes.EXPENSE) {
        filteredList.add(t);
      }
    }

    return UnmodifiableListView(filteredList.reversed);
  }

  double get totalAmount {
    double sum = 0;
    for(Transaction transaction in _transactionList) {
      sum += transaction.transactionType == TransactionTypes.INCOME ? transaction.getAmount() : -1 * transaction.getAmount();
    }
    return sum;
  }

  double get totalAmountIncomes {
    double sum = 0;
    for(Transaction transaction in _transactionList) {
      if(transaction.getTransactionType() == TransactionTypes.INCOME) {
        sum += transaction.getAmount();
      }
    }
    return sum;
  }

  double get totalAmountExpanses {
    double sum = 0;
    for(Transaction transaction in _transactionList) {
      if(transaction.getTransactionType() == TransactionTypes.EXPENSE) {
        sum += transaction.getAmount();
      }
    }
    return sum;
  }

  void addTransaction (String text, double amount, String type) {
      TransactionTypes selectedType = TransactionTypes.INCOME;

      for(TransactionTypes t in TransactionTypes.values) {
        if(t.name.toLowerCase() == type.toLowerCase()) {
          selectedType = t;
        }
      }

      _transactionList.add(Transaction("0", text, amount, selectedType));

      notifyListeners();
  }
}