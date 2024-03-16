extension StringExtension on String {
  // Convert from Kelvin to Celsius
  String toCelsius() {
    final double tempInKelvin = double.tryParse(this) ?? 0.0;

    final double tempInCelsius = tempInKelvin - 273.15;

    return tempInCelsius.toStringAsFixed(0);
  }
}
