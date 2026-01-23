// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:et/models/expense.dart';
// import 'package:et/widget/expenses.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _numberController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCat = Category.leisure;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  // var _enteredTitle = "";   //-> THIS IS THE FIRST WAY TO HANDLE INPUT

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  void _sumbitData() {
    final enteredCost = double.tryParse(
      _numberController.text,
    ); // this is a safe way to convert number string to number int/double.
    final amountInvalid = (enteredCost == null) || (enteredCost <= 0);

    // print(_titleController.text);
    // print(_numberController.text);

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("You fucking dumbass"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );

      return;
    } else {
      var toBeAddedExpen = Expense(
        title: _titleController.text,
        amount: enteredCost,
        date: _selectedDate!,
        cat: _selectedCat,
      );

      widget.onAddExpense(toBeAddedExpen);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardAdjustment = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SingleChildScrollView(
          // final width = MediaQuery.
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardAdjustment + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          // onChanged: _saveTitleInput,     //-> THIS IS THE FIRST WAY TO HANDLE INPUT
                          controller: _titleController,
                          maxLength: 50,
                          decoration: InputDecoration(label: Text("Yabadabdo")),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _numberController,
                          // maxLength: 50,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    // onChanged: _saveTitleInput,     //-> THIS IS THE FIRST WAY TO HANDLE INPUT
                    controller: _titleController,
                    maxLength: 50,
                    decoration: InputDecoration(label: Text("Yabadabdo")),
                  ),

                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCat,
                        items: Category.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          // print(value);
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCat = value;
                          });
                        },
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected'
                                  : formatter.format(_selectedDate!),
                            ), // ! is for bruteforcing dart.
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _numberController,
                          // maxLength: 50,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Date Selected'
                                  : formatter.format(_selectedDate!),
                            ), // ! is for bruteforcing dart.
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 16),
                if (width >= 600)
                  Row(children: [
                    const Spacer(),

                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          _sumbitData();
                        },
                        child: const Text("Save Expenses"),
                      ),
                  ],)
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCat,
                        items: Category.values
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          // print(value);
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCat = value;
                          });
                        },
                      ),

                      const Spacer(),

                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          _sumbitData();
                        },
                        child: const Text("Save Expenses"),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
