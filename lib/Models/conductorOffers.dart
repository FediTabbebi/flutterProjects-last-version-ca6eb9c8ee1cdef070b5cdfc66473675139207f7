class AllOffers {
  AllOffers(
      {required this.getDepart,
      required this.getArrivee,
      required this.getResponse,
      required this.getDeliveryTime,
      required this.getFreightType,
      required this.getQuantity,
      required this.getOffreId,
      required this.getUsername,
      required this.getUserDescription});
  late final String getDepart;
  late final String getArrivee;
  late final String getResponse;
  late final String getDeliveryTime;
  late final String getFreightType;
  late final String getQuantity;
  late final String getOffreId;
  late final String getUsername;
  late final String getUserDescription;
  AllOffers.fromJson(Map<String, dynamic> json) {
    getArrivee = json["arrivee"];
    getDepart = json["depart"];
    getFreightType = json["deliveryType"];
    getUserDescription = json["description"];
    getUsername = json["user"]["username"];
    getQuantity = json["quantity"];
    getDeliveryTime = json["time"];
    getResponse = json["load"];
    getOffreId = json["id"];
  }
}

class RegisteredOffers {
  RegisteredOffers({
    required this.getDepart,
    required this.getArrivee,
    required this.getResponse,
    required this.getDeliveryTime,
    required this.getFreightType,
    required this.getQuantity,
    required this.getOffreId,
    required this.getUserDescription,
    required this.getUsername,
    required this.getTruckName,
    required this.getPrice,
    required this.getDescription,
  });
  late final String getDepart;
  late final String getArrivee;
  late final String getResponse;
  late final String getDeliveryTime;
  late final String getFreightType;
  late final String getQuantity;
  late final String getOffreId;
  late final String getUsername;
  late final String getTruckName;
  late final int getPrice;
  late final String getDescription;
  late final String getUserDescription;

  RegisteredOffers.fromJson(Map<String, dynamic> json) {
    getArrivee = json["offer"]["arrivee"];
    getDepart = json["offer"]["depart"];
    getFreightType = json["offer"]["deliveryType"];
    getUsername = json["offer"]["user"]["username"];
    getUserDescription = json["offer"]["description"];
    getQuantity = json["offer"]["quantity"];
    getDeliveryTime = json["offer"]["time"];
    getResponse = json["offer"]["load"];
    getOffreId = json["id"];
    getTruckName = json["truck"]["truckModel"];
    getPrice = json["price"];
    getDescription = json["description"];
  }
}
