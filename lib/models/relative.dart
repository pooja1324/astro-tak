import 'package:india_today_assignment/models/place.dart';
import 'package:india_today_assignment/models/relation_names.dart';

class Relative {
  final String uuid;
  final String firstName, lastName, gender, meridiem;
  final Place place;
  final RelationNames relationNames;
  final int dobDay, dobMonth, dobYear, tobHour, tobMin;

  Relative(
      this.uuid,
      this.firstName,
      this.lastName,
      this.gender,
      this.meridiem,
      this.relationNames,
      this.place,
      this.dobDay,
      this.dobMonth,
      this.dobYear,
      this.tobHour,
      this.tobMin);

  factory Relative.fromJson(Map<String, dynamic> json) {
    late RelationNames relationName;
   for(RelationNames relation in relations){
     if(relation.id==json['relationId']){
       relationName=relation;
       break;
     }
   }
    return Relative(
      json['uuid'],
      json['firstName'],
      json['lastName'],
      json['gender'],
      json['birthDetails']['meridiem'],
      relationName,
      Place(json['birthPlace']['placeName'],json['birthPlace']['placeId'] ),
      json['birthDetails']['dobDay'],
      json['birthDetails']['dobMonth'],
      json['birthDetails']['dobYear'],
      json['birthDetails']['tobHour'],
      json['birthDetails']['tobMin'],

    );
  }
}
