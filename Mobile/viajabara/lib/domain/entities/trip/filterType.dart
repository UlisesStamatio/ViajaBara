enum FilterType {
  START_ADDRESS,
  END_ADDRESS,
  STOP_OVER,
}

// Métodos de extensión para convertir entre String y FilterType
extension FilterTypeExtension on FilterType {
  String get value {
    switch (this) {
      case FilterType.START_ADDRESS:
        return 'Viaje completo';
      case FilterType.END_ADDRESS:
        return 'Viaje completo';
      case FilterType.STOP_OVER:
        return 'Parada';
    }
  }

  static FilterType fromValue(String value) {
    switch (value) {
      case 'START_ADDRESS' || 'Viaje completo':
        return FilterType.START_ADDRESS;
      case 'END_ADDRESS' || 'Viaje completo':
        return FilterType.END_ADDRESS;
      case 'STOP_OVER' || 'Parada':
        return FilterType.STOP_OVER;
      default:
        throw ArgumentError('Valor no válido para FilterType: $value');
    }
  }
}
