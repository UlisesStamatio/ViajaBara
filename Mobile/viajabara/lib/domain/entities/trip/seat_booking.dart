class SeatBooking {
  String seatNumber;
  final int passengerNumber;

  SeatBooking({
    required this.seatNumber,
    required this.passengerNumber,
  });

  factory SeatBooking.fromJson(Map<String, dynamic> json) {
    return SeatBooking(
      seatNumber: json['seatNumber'],
      passengerNumber: json['passengerNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatNumber': seatNumber,
      'passengerNumber': passengerNumber,
    };
  }

  @override
  String toString() {
    return 'SeatBooking{seatNumber: $seatNumber, passengerNumber: $passengerNumber}';
  }
}
