import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Expenses(), // Ensure this is the root widget inside MaterialApp
    ),
  );
}
