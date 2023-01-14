import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import '/widgets/new_transaction.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
//import 'models/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 30),
          )).copyWith(
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: Colors.blueGrey, secondary: Colors.amber),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: "Walmart", title: "Groceries", amount: 109.55, date: DateTime.now()),
    // Transaction(
    //     id: "Target", title: "Clothes", amount: 19.99, date: DateTime.now()),
    // Transaction(
    //     id: "Dick's", title: "Showes", amount: 309.55, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newTX);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height - 
                appBar.preferredSize.height - 
                MediaQuery.of(context).padding.top) * 0.3,
                child: Chart(_recentTransactions)),
              Container(
                  height: (MediaQuery.of(context).size.height - 
                  appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
                  child: TransactionList(_userTransactions, _deleteTransaction))
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
