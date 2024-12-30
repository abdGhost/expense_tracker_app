import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../model/expense.dart';
import 'expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExppenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Flutter Course 2',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openAddExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, // Ensure it's the correct context with Scaffold
      builder: (ctx) {
        return NewExpense(onAddExpense: _addExense);
      },
    );
  }

  void _addExense(Expense expense) {
    setState(() {
      _registeredExppenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final _expenseIndex = _registeredExppenses.indexOf(expense);

    setState(() {
      _registeredExppenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExppenses.insert(
                _expenseIndex,
                expense,
              );
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses found. Start adding now!'),
    );

    if (_registeredExppenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExppenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Expense Tracker',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                _openAddExpenseOverlay(context), // Explicit context passed
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExppenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
