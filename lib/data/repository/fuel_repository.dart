import '../service/fuel_service.dart';

class FuelRepository {
  final FuelService _fuelService;

  FuelRepository(this._fuelService);

  String getBestOption({
    required double alcoholPrice,
    required double gasolinePrice,
    required double distance,
    required double alcoholConsumption,
    required double gasolineConsumption,
  }) {
    final alcoholCost = _fuelService.calculateAlcoholCost(
      alcoholPrice: alcoholPrice,
      distance: distance,
      alcoholConsumption: alcoholConsumption,
    );
    final gasolineCost = _fuelService.calculateGasolineCost(
      gasolinePrice: gasolinePrice,
      distance: distance,
      gasolineConsumption: gasolineConsumption,
    );

    return alcoholCost <= gasolineCost ? 'Álcool' : 'Gasolina';
  }

  double calculateSavings({
    required double alcoholPrice,
    required double gasolinePrice,
    required double distance,
    required double alcoholConsumption,
    required double gasolineConsumption,
  }) {
    final alcoholCost = _fuelService.calculateAlcoholCost(
      alcoholPrice: alcoholPrice,
      distance: distance,
      alcoholConsumption: alcoholConsumption,
    );
    final gasolineCost = _fuelService.calculateGasolineCost(
      gasolinePrice: gasolinePrice,
      distance: distance,
      gasolineConsumption: gasolineConsumption,
    );

    return (alcoholCost - gasolineCost).abs();
  }
}
