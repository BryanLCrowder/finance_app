import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import '/widgets/new_transaction.dart';

import 'models/transaction.dart';
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
            fontWeight: FontWeight.bold,)
        ),
        appBarTheme: AppBarTheme(titleTextStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 30),)
      ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: Colors.blueGrey,
          secondary: Colors.amber),
          ),
      //theme: ThemeData(
      //  primarySwatch: Colors.blueGrey,
      //  accentColor: Colors.amber
      //),
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

  void _addNewTransaction(String txtitle, double txamount) {
    final newTX = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTX);
    });
  }


void _startAddNewTransaction(BuildContext ctx) {
showModalBottomSheet(context: ctx, builder: (_) {
return GestureDetector(
  child: NewTransaction(_addNewTransaction),
  onTap: () {},
  behavior: HitTestBehavior.opaque,);
  },);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(onPressed: () =>_startAddNewTransaction(context),icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('Chart'),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions)
          ],
        ),
      ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: 
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>_startAddNewTransaction(context),),
    );
  }
}
