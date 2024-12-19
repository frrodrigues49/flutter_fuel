import 'package:flutter/material.dart';
import 'package:flutter_fuel/core/theme/app_theme.dart';
import 'package:flutter_fuel/ui/view/fuel_calculator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gasolina x Alcool',
      theme: AppTheme.darkTheme,
      home: FuelCalculatorPage(),
    );
  }
}

