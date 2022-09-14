import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction(this.addTX);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTX(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                controller: titleController,
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(labelText: "Title")),
            TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
                onSubmitted: (_) => submitData(),
                decoration: InputDecoration(labelText: "Amount")),
            TextButton(
                onPressed: submitData,
                style: TextButton.styleFrom(primary: Colors.purple),
                child: Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
