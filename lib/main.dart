import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/new_transection.dart';
import 'package:personal_expense/widgets/transection_list.dart';
import 'models/Transection.dart';
import './widgets/chart.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Manager', // where it showes????
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        errorColor: Colors.red,
        fontFamily: 'Times New Roman',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transection> _transections = [
    /*Transection(
      id: 'd1',
      amount: 22.5,
      time: DateTime.now(),
      title: 'Grocerries',
    ),
    Transection(
      id: 'd2',
      amount: 99.5,
      time: DateTime.now(),
      title: 'Speaker',
    ),*/
  ];

  void _deleteTransection(String id) {
    setState(() {
      _transections.removeWhere((element) => element.id == id);
    });
  }

  void _addNewTransection(
      String txTitle, double txAmount, DateTime choosenDate) {
    Transection tx = Transection(
      amount: txAmount,
      title: txTitle,
      time: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _transections.add(tx);
    });
  }

  void _startAddNewTransection(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransection(_addNewTransection);
      },
    );
  }

  List<Transection> get _recentTransections {
    return _transections.where((element) {
      return element.time.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Manager'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransection(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(_recentTransections),
          TransectionList(_transections, _deleteTransection),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransection(context),
      ),
    );
  }
}
