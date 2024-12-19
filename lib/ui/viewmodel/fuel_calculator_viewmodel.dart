import '../../data/repository/fuel_repository.dart';

class FuelCalculatorViewModel {
  final FuelRepository _repository;

  FuelCalculatorViewModel(this._repository);

  String getBestOption({
    required double alcoholPrice,
    required double gasolinePrice,
    required double distance,
    required double alcoholConsumption,
    required double gasolineConsumption,
  }) {
    return _repository.getBestOption(
      alcoholPrice: alcoholPrice,
      gasolinePrice: gasolinePrice,
      distance: distance,
      alcoholConsumption: alcoholConsumption,
      gasolineConsumption: gasolineConsumption,
    );
  }

  double calculateSavings({
    required double alcoholPrice,
    required double gasolinePrice,
    required double distance,
    required double alcoholConsumption,
    required double gasolineConsumption,
  }) {
    return _repository.calculateSavings(
      alcoholPrice: alcoholPrice,
      gasolinePrice: gasolinePrice,
      distance: distance,
      alcoholConsumption: alcoholConsumption,
      gasolineConsumption: gasolineConsumption,
    );
  }
}
