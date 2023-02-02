//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransection extends StatefulWidget {
  final Function addNewTransection;

  NewTransection(this.addNewTransection);

  @override
  State<NewTransection> createState() => _NewTransectionState();
}

class _NewTransectionState extends State<NewTransection> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _dateTimeController;

  void _submitData() {
    if (amountController.text.isEmpty) return;

    final String title = titleController.text;
    final double amount = double.parse(amountController.text);

    if (title.isEmpty || amount < 0 || _dateTimeController == null) return;

    widget.addNewTransection(title, amount, _dateTimeController);

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _dateTimeController = pickedDate;
      });
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
          children: [
            TextField(
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Name your transection',
                label: Text('Title'),
              ),
              //onChanged: ((value) => titleInput = value),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Enter amount',
                label: Text('Amount'),
              ),
              //onChanged: ((value) => amountInput = value),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_dateTimeController != null
                        ? 'Picked Date : ${DateFormat.yMd().format(_dateTimeController)}'
                        : 'No Date Chosen!'),
                  ),
                  TextButton(
                    onPressed: _datePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text(
                'Add Transection',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
