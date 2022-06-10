class OffreModel {
  OffreModel(
      {required this.getDepart,
      required this.getArrivee,
      required this.getResponse,
      required this.getDeliveryTime,
      required this.getFreightType,
      required this.getQuantity,
      required this.getOffreId,
      required this.getDescription});
  late final String getDepart;
  late final String getArrivee;
  late final String getResponse;
  late final String getDeliveryTime;
  late final String getFreightType;
  late final String getQuantity;
  late final String getOffreId;
  late final String getDescription;

  OffreModel.fromJson(Map<String, dynamic> json) {
    getDepart = json["depart"];
    getArrivee = json["arrivee"];
    getResponse = json["load"];
    getDeliveryTime = json["time"];
    getFreightType = json["deliveryType"];
    getQuantity = json["quantity"];
    getOffreId = json["id"];
    getDescription = json["description"];
  }
}

class UserOffers {
  UserOffers({
    required this.getDepart,
    required this.getArrivee,
    required this.getResponse,
    required this.getDeliveryTime,
    required this.getFreightType,
    required this.getQuantity,
    required this.getOffreId,
    required this.getUserDescription,

    required this.getConductorName,
    required this.getTruckName,
    required this.getPrice,
    required this.getDescription,
    required this.getDate,
    required this.getUserOffreID,
  });
  late final String getDepart;
  late final String getArrivee;
  late final String getResponse;
  late final String getDeliveryTime;
  late final String getFreightType;
  late final String getQuantity;
  late final String getOffreId;
  late final String getConductorName;
  late final String getTruckName;
  late final int getPrice;
  late final String getDescription;
  late final String getDate;
  late final String getUserDescription;
  late final String getUserOffreID;


  UserOffers.fromJson(Map<String, dynamic> json) {
    getArrivee = json["offer"]["arrivee"];
    getUserOffreID = json["offer"]["id"];
    getDepart = json["offer"]["depart"];
    getFreightType = json["offer"]["deliveryType"];
    getUserDescription = json["offer"]["description"];
    getConductorName = json["conducteur"]["username"];
    getQuantity = json["offer"]["quantity"];
    getDeliveryTime = json["offer"]["time"];
    getResponse = json["offer"]["load"];
    getOffreId = json["id"];
    getTruckName = json["truck"]["truckModel"];
    getPrice = json["price"];
    getDescription = json["description"];
    getDate = getDate;
   
  }
}
