import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

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
    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                //onChanged: (value) {
                //titleInput = value;
                //},
                controller: titleController,
                onSubmitted: (val) => submitData()),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              // onChanged: (value) {
              // amountInput = value;
              //},
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (val) => submitData(),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text(
                'Add transaction',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
