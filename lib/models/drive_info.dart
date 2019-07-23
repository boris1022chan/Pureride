class DriveInfo {
  final String destinationName;
  final String address;
  final DateTime departureTime;
  final String driver;
  final List taggerAlongers;
  final bool isOffer;

  DriveInfo({
    this.destinationName,
    this.address,
    this.departureTime,
    this.driver,
    this.taggerAlongers,
    this.isOffer
  });
}
