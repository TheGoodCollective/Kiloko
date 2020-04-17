

class KilokoLocation {
  int id;
  double lat;
  double lng;
  double isSynced;
  String cloudID;
  DateTime addedOn;

  KilokoLocation({
    this.id, this.lat, this.lng, this.isSynced, this.cloudID,
    this.addedOn
  });

  static KilokoLocation fromMap({ Map<String, dynamic> location }) {

    return KilokoLocation(
      id: location['id'],
      lat: location['lat'],
      lng: location['lng'],
      isSynced: location['isSynced'],
      cloudID: location['cloudID'],
      addedOn: location['addedOn'] ?? DateTime.now(),
    );
  }// static KilokoLocation fromMap({ Map<String, dynamic> location }) { .. }

  static Map<String, dynamic> toMap({ KilokoLocation location }) {

    return {
      'id': location.id,
      'lat': location.lat,
      'lng': location.lng,
      'isSynced': location.isSynced,
      'cloudID': location.cloudID,
      'addedOn': location.addedOn,
    };
  }// static Map<String, dynamic> toMap({ KilokoLocation location }) { .. }

}