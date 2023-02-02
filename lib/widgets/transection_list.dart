import 'package:flutter/material.dart';
import '../models/Transection.dart';
import 'package:intl/intl.dart';

class TransectionList extends StatelessWidget {
  final List<Transection> transections;

  Function deleteTransaction;

  TransectionList(this.transections, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transections.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No data yet!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              //scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transections[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transections[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transections[index].time),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () =>
                          deleteTransaction(transections[index].id),
                    ),
                  ),
                );
              },
              itemCount: transections.length,
            ),
    );
  }
}
