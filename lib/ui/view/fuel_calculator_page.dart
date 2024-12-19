import 'package:flutter/material.dart';
import 'package:flutter_fuel/core/utils/parse_currency.dart';
import '../../core/utils/currency_formatter.dart';
import '../viewmodel/fuel_calculator_viewmodel.dart';
import '../../data/repository/fuel_repository.dart';
import '../../data/service/fuel_service.dart';

class FuelCalculatorPage extends StatelessWidget {
  final _alcoholPriceController = TextEditingController();
  final _gasolinePriceController = TextEditingController();
  final _distanceController = TextEditingController();
  final _alcoholConsumptionController = TextEditingController();
  final _gasolineConsumptionController = TextEditingController();

  final _viewModel = FuelCalculatorViewModel(
    FuelRepository(FuelService()),
  );

  FuelCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cálculo de Combustível')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _alcoholPriceController,
              decoration: const InputDecoration(labelText: 'Preço do Álcool (R\$)'),
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyFormatter()],
            ),
            TextField(
              controller: _gasolinePriceController,
              decoration: const InputDecoration(labelText: 'Preço da Gasolina (R\$)'),
              keyboardType: TextInputType.number,
              inputFormatters: [CurrencyFormatter()],
            ),
            TextField(
              controller: _distanceController,
              decoration: const InputDecoration(labelText: 'Distância (km)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _alcoholConsumptionController,
              decoration: const InputDecoration(labelText: 'Consumo com Álcool (km/l)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _gasolineConsumptionController,
              decoration: const InputDecoration(labelText: 'Consumo com Gasolina (km/l)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final alcoholPrice = _alcoholPriceController.text.parseCurrency();
                final gasolinePrice = _gasolinePriceController.text.parseCurrency();
                final distance = double.tryParse(_distanceController.text);
                final alcoholConsumption = double.tryParse(_alcoholConsumptionController.text);
                final gasolineConsumption = double.tryParse(_gasolineConsumptionController.text);
                
                if ([alcoholPrice, gasolinePrice, distance, alcoholConsumption, gasolineConsumption].contains(null)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos!')));
                  return;
                }

                final betterOption = _viewModel.getBestOption(
                  alcoholPrice: alcoholPrice!,
                  gasolinePrice: gasolinePrice!,
                  distance: distance!,
                  alcoholConsumption: alcoholConsumption!,
                  gasolineConsumption: gasolineConsumption!,
                );

                final savings = _viewModel.calculateSavings(
                  alcoholPrice: alcoholPrice,
                  gasolinePrice: gasolinePrice,
                  distance: distance,
                  alcoholConsumption: alcoholConsumption,
                  gasolineConsumption: gasolineConsumption,
                );

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Resultado'),
                    content: Text('$betterOption é mais vantajoso.\nEconomia de R\$ ${savings.toStringAsFixed(2)}.'),
                  ),
                );
              },
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
