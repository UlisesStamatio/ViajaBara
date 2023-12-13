enum FilterType {
  FULL_TRAVEL,
  STOPPER,
}

// Métodos de extensión para convertir entre String y FilterType
extension FilterTypeExtension on FilterType {
  String get value {
    switch (this) {
      case FilterType.FULL_TRAVEL:
        return 'Viaje completo';
      case FilterType.STOPPER:
        return 'Parada';
    }
  }

  static FilterType fromValue(String value) {
    switch (value) {
      case 'FULL_TRAVEL' || 'Viaje completo':
        return FilterType.FULL_TRAVEL;
      case 'STOPPER' || 'Parada':
        return FilterType.STOPPER;
      default:
        throw ArgumentError('Valor no válido para FilterType: $value');
    }
  }
}
