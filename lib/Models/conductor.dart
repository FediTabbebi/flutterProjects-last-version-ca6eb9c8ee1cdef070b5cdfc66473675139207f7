class Conductor {
  Conductor(
    this.conductorName,
    this.conductorEmail,
    this.Truck,
    this.creationDate,
    this.conductorId,
    this.Status,
  );
  late final String? conductorName;
  late final String? conductorEmail;
  late final Truck;
  late final String? creationDate;
  late final String? conductorId;
  late final String? Status;

  Conductor.fromJson(Map<String, dynamic> json) {
    conductorName = json['username'];
    conductorEmail = json['email'];
    Truck = json["truck"];
    creationDate = creationDate;
    conductorId = json["id"];
    Status = json["status"];
  }
}
