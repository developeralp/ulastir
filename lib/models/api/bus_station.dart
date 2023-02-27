class BusStation {
  BusStation({
    this.lat,
    this.lng,
    this.id,
    this.name,
    this.code,
  });

  double? lat;
  double? lng;
  int? id;
  String? name;
  String? code;

  factory BusStation.fromJson(Map<String, dynamic> json) => BusStation(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "id": id,
        "name": name,
        "code": code,
      };
}
