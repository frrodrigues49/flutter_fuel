import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _alcoholPriceController = TextEditingController();
  final TextEditingController _gasolinePriceController =
      TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _alcoholConsumptionController =
      TextEditingController();
  final TextEditingController _gasolineConsumptionController =
      TextEditingController();

  String? _result;
  String? _savings;

  final NumberFormat _currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  final NumberFormat _numberFormatter = NumberFormat.decimalPattern('pt_BR');

  void _calculate() {
    final double? alcoholPrice = _parseCurrency(_alcoholPriceController.text);
    final double? gasolinePrice = _parseCurrency(_gasolinePriceController.text);
    final double? distance = double.tryParse(_distanceController.text);
    final double? alcoholConsumption =
        double.tryParse(_alcoholConsumptionController.text);
    final double? gasolineConsumption =
        double.tryParse(_gasolineConsumptionController.text);

    if (alcoholPrice != null &&
        gasolinePrice != null &&
        distance != null &&
        alcoholConsumption != null &&
        gasolineConsumption != null) {
      final double alcoholCost = (distance / alcoholConsumption) * alcoholPrice;
      final double gasolineCost =
          (distance / gasolineConsumption) * gasolinePrice;
      final String betterOption =
          alcoholCost <= gasolineCost ? 'Álcool' : 'Gasolina';
      final double savedAmount = (alcoholCost - gasolineCost).abs();

      setState(() {
        _result = '$betterOption é mais vantajoso';
        _savings =
            'Economia de ${_currencyFormatter.format(savedAmount)} para ${_numberFormatter.format(distance)} km.';
      });
    } else {
      setState(() {
        _result = 'Por favor, insira valores válidos.';
        _savings = null;
      });
    }
  }

  double? _parseCurrency(String value) {
    try {
      return NumberFormat.simpleCurrency(locale: 'pt_BR')
          .parse(value)
          .toDouble();
    } catch (e) {
      return double.tryParse(value.replaceAll(',', '.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Combustível'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _alcoholPriceController,
              decoration:
                  const InputDecoration(labelText: 'Preço do Álcool (R\$)'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
            ),
            TextField(
              controller: _gasolinePriceController,
              decoration:
                  const InputDecoration(labelText: 'Preço da Gasolina (R\$)'),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
            ),
            TextField(
              controller: _distanceController,
              decoration: const InputDecoration(labelText: 'Distância (km)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _alcoholConsumptionController,
              decoration:
                  const InputDecoration(labelText: 'Consumo com Álcool (km/l)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _gasolineConsumptionController,
              decoration: const InputDecoration(
                  labelText: 'Consumo com Gasolina (km/l)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calcular'),
            ),
            if (_result != null) ...[
              const SizedBox(height: 20),
              Text(
                _result!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (_savings != null)
                Text(
                  _savings!,
                  style: const TextStyle(fontSize: 16),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;

    double value = double.tryParse(text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final newText = formatter.format(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
