class Address {
  Address(
      {this.street,
      this.number,
      this.complement,
      this.district,
      this.zipCode,
      this.city,
      this.state,
      this.lat,
      this.long});

  String street;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;

  double lat;
  double long;

  @override
  String toString() {
    return 'Address{street: $street, number: $number, complement: $complement, district: $district, zipCode: $zipCode, city: $city, state: $state, lat: $lat, long: $long}';
  }
}
