import 'dart:developer';

import 'package:budget_app/modules/TransactionModel.dart';
import 'package:budget_app/routes/AddTransactionBottomSheet.dart';
import 'package:budget_app/routes/ExpenseRoute.dart';
import 'package:budget_app/routes/IncomeRoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => TransactionModel(),
        child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isIncomeSelected = true;

  void selectIncome() {
    setState(() {
      isIncomeSelected = true;
    });
  }

  void selectExpense() {
    setState(() {
      isIncomeSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(8, 32, 8, 16),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('graphics/hero_image.png'),
                ),
              ),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Card(
                        child: SizedBox(
                          width: 200,
                          height: 100,
                          child: Center( child: Consumer<TransactionModel>(
                            builder: (context, transactionModel, child) => Stack(
                              children: [
                                if(child != null) child,
                                Text('€${transactionModel.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 32)),
                              ],
                            )
                          )),
                        ),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            showBottomSheet<void>(
                              context: context,
                              builder: (context) {
                                return const AddTransactionBottomSheet();
                              },
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Money'),
                          style: const ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromRGBO(214, 54, 114, 100)
                              ),
                              textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 18))
                          ),
                      )
                    ],
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: isIncomeSelected ? null : const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.grey)),
                  onPressed: selectIncome,
                  child: const Text('Incomes'),
                ),
                ElevatedButton(
                  style: !isIncomeSelected ? null : const ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.grey)),
                  onPressed: selectExpense,
                  child: const Text('Expense'),
                )
              ]
            ),
            Expanded(child: isIncomeSelected ? const IncomeRoute() : const ExpanseRoute())
            
          ],// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
