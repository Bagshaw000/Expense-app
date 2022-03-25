import 'package:flutter/services.dart';

import './widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  //To enable different mode in which the app would be rendered
  // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations(
  //  [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput = '';

  final List<Transaction> _userTransaction = [
    Transaction(
        id: 't1', title: 'New shoes', amount: 59.22, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Clothes', amount: 30.31, date: DateTime.now()),
  ];

  bool _showChart = false;
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now.toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              child: NewTransaction(_addNewTransaction),
              behavior: HitTestBehavior.opaque);
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Flutter App'),
      backgroundColor: Colors.purple,
      actions: <Widget>[
        IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add)),
      ],
    );
    final txList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show Chart'),
                    //Switch button
                    Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    )
                  ],
                ),
              Card(
                child: Container(
                  width: double.infinity,
                  child: Text('CHART'),
                  color: Theme.of(context).primaryColor,
                ),
                elevation: 5,
              ),
              if (!isLandscape)
                Container(
                    height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransaction)),
                if(!isLandscape)txList,
               if(isLandscape) _showChart
                    ?
                    : txList,
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
