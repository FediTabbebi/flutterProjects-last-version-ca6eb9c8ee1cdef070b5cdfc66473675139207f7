class Truck {
  Truck(
    this.TruckModel,
    this.TruckLicense,
    this.TruckId,
  );
  late final String? TruckModel;
  late final String? TruckLicense;
  late final String? TruckId;

  Truck.fromJson(Map<String, dynamic> json) {
    TruckModel = json['truckModel'];
    TruckLicense = json['truckLicense'];
    TruckId = json['id'];
  }
}
