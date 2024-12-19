class FuelService {
  double calculateAlcoholCost({
    required double alcoholPrice,
    required double distance,
    required double alcoholConsumption,
  }) {
    return (distance / alcoholConsumption) * alcoholPrice;
  }

  double calculateGasolineCost({
    required double gasolinePrice,
    required double distance,
    required double gasolineConsumption,
  }) {
    return (distance / gasolineConsumption) * gasolinePrice;
  }
}
