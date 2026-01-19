import 'package:et/expenses_list.dart';
import 'package:et/models/expense.dart';
import 'package:et/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Fried Chicken Sandwhich',
      amount: 19.99,
      date: DateTime.now(),
      cat: Category.food,
    ),
    Expense(
      title: 'E-reader',
      amount: 19.98,
      date: DateTime.now(),
      cat: Category.leisure,
    ),
    Expense(
      title: 'Laptop',
      amount: 19.97,
      date: DateTime.now(),
      cat: Category.work,
    ),
    Expense(
      title: 'Backpack',
      amount: 19.96,
      date: DateTime.now(),
      cat: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    // underscore because private
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    ); // a utility function
  }

  void _removeExpense(Expense e) {
    final num = _registeredExpenses.indexOf(e);
    setState(() {
      _registeredExpenses.remove(e);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${e.title} Deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(num, e);
            });
          },
        ),
      ),
    );
  }

  void _addExpense(Expense e) {
    setState(() {
      _registeredExpenses.add(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses Found! Start adding more!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      setState(() {
        mainContent = ExpenseList(
          expenses: _registeredExpenses,
          removedExpense: _removeExpense,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        // flutter has a dedicated widget/function thingy for a bar.
        // backgroundColor: const Color.fromARGB(255, 165, 211, 249),
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            // a built in widget for just an icon
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // toolbar with add button -> Row() is a way to do it.
          const Text('The chart'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}


