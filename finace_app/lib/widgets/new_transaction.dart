import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

int randomNumber() {
  var random = new Random();
  int min = 0;
  int max = 9;

  return min + random.nextInt(max - min);
}

class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction(this.addTX);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectDate;

  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectDate == null) {
      return;
    }

    widget.addTX(
      enteredTitle, 
      enteredAmount,
      _selectDate);

    Navigator.of(context).pop();
  }

  void _precentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      } else {
        setState(() {
          _selectDate = pickedData;
        });
      }
    });
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
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(labelText: "Title")),
            TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(labelText: "Amount")),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectDate)}'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _precentDatePicker,
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.primary,
                          onPrimary: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: _submitData,
                style: TextButton.styleFrom(primary: Colors.purple),
                child: Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
