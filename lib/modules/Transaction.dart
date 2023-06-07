import 'package:budget_app/modules/TransactionTypes.dart';
import 'package:flutter/cupertino.dart';

class Transaction {
  String id;
  String text;
  double amount;
  TransactionTypes transactionType;

  Transaction(this.id, this.text, this.amount, this.transactionType);

  String getID () {
    return id;
  }

  void setID (String id) {
    this.id = id;
  }

  String getText () {
    return text;
  }

  void setText (String text) {
    this.text = text;
  }

  double getAmount () {
    return amount;
  }

  void setAmount (double amount) {
    this.amount = amount;
  }

  TransactionTypes getTransactionType () {
    return transactionType;
  }

  void setTransactionType (TransactionTypes transactionType) {
    this.transactionType = transactionType;
  }
}