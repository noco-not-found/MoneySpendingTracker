import 'package:et/widget/expenses%20List/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:et/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.removedExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense e) removedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(index),
        onDismissed: (direction) {
          removedExpense(expenses[index]);
        },
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
