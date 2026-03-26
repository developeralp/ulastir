class RailDirection {
  int? id;
  String? name;
  String? directionType;
  String? fee;
  String? discountedFee;
  String? studentFee;
  String? duration;

  RailDirection({
    this.id,
    this.name,
    this.directionType,
    this.fee,
    this.discountedFee,
    this.studentFee,
    this.duration,
  });

  factory RailDirection.fromJson(Map<String, dynamic> json) => RailDirection(
        id: json["id"],
        name: json["name"],
        directionType: json["direction_type"],
        fee: json["fee"],
        discountedFee: json["discounted_fee"],
        studentFee: json["student_fee"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "direction_type": directionType,
        "fee": fee,
        "discounted_fee": discountedFee,
        "student_fee": studentFee,
        "duration": duration,
      };
}
