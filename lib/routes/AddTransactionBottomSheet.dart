import 'dart:ffi';

import 'package:budget_app/modules/TransactionModel.dart';
import 'package:budget_app/modules/TransactionTypes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  State<AddTransactionBottomSheet> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransactionBottomSheet> {

  TextEditingController textController = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController type = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: TransactionTypes.INCOME.name.toString(), child: Text(TransactionTypes.INCOME.name.toString())),
      DropdownMenuItem(value: TransactionTypes.EXPENSE.name.toString(), child: Text(TransactionTypes.EXPENSE.name.toString())),
    ];
    return menuItems;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height / 2,
      child: Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
                validator: (val) {
                  if(val == null || val.isEmpty) {
                    return 'Please enter Text';
                  }
                  return null;
                },
                onChanged: (val) => textController.text = val,
                decoration: const InputDecoration(
                  labelText: 'Transaction Text',
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (val) {
                  final regex = RegExp(r'^\d+(\.\d{0,2})?$');
                  if(regex.hasMatch(val!)) {
                    return null;
                  }
                  return 'Enter a valid number';
                },
                onChanged: (val) => amount.text = val,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: DropdownButtonFormField(

                items: dropdownItems,

                validator: (val) {
                  if(val == null) {
                    return 'Enter transaction type';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Transaction Type',
                ), onChanged: (String? value) { type.text = value!; },),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saving Transaction')),
                    );
                    Provider.of<TransactionModel>(context, listen:false).addTransaction(textController.value.text, double.parse(amount.value.text), type.value.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('SAVE'),
            ),
          ),
        ],
      ),
      ),
    );
  }

}