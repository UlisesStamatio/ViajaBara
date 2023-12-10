class Qualifications {
  int? id;
  String? comments;
  double? score;
  double? cost;
  String? clientPhoto;

  Qualifications({
    this.id,
    this.comments,
    this.score,
    this.cost,
    this.clientPhoto,
  });

  factory Qualifications.fromJson(Map<String, dynamic> json) {
    return Qualifications(
      id: json['id'],
      comments: json['comments'],
      score: json['score'],
      cost: json['cost'],
      clientPhoto: json['seatingSales']['client']['profile'],
    );
  }
}
