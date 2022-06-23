class Place{
  String name;
  String id;
  Place(this.name, this.id);
  factory Place.fromJson(Map<String,dynamic> json){
    return Place(json['placeName'], json['placeId']);
  }
}