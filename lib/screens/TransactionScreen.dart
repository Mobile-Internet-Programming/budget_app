import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  String text;
  double amount;

  TransactionScreen({super.key, required this.text, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(flex: 1, child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Text('€${amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

}