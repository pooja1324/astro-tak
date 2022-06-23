import 'package:equatable/equatable.dart';
import 'package:india_today_assignment/models/place.dart';
import 'package:india_today_assignment/models/relation_names.dart';
import 'package:india_today_assignment/models/relative.dart';

abstract class MyProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TabChangeEvent extends MyProfileEvent {
  final int index;

  TabChangeEvent(this.index);
}

class FetchRelativesEvent extends MyProfileEvent {}

class NewProfileAddingEvent extends MyProfileEvent {
  final bool isAdding;
  final Relative? relative;

  NewProfileAddingEvent(this.isAdding, {this.relative});
}

class GenderChangedEvent extends MyProfileEvent {
  final String gender;

  GenderChangedEvent(this.gender);
}

class RelationChangedEvent extends MyProfileEvent {
  final RelationNames relation;

  RelationChangedEvent(this.relation);
}
class MeridiemChangedEvent extends MyProfileEvent {
  final String meridiem;

  MeridiemChangedEvent(this.meridiem);
}

class PlaceSearchEvent extends MyProfileEvent {
  final String search;

  PlaceSearchEvent(this.search);
}
class DeleteRelativeEvent extends MyProfileEvent {
  final Relative relative;

  DeleteRelativeEvent(this.relative);
}

class AddRelativeEvent extends MyProfileEvent {
  final String firstName, lastName, gender, meridiem;
  final Place place;
  final RelationNames relationNames;
  final int dobDay, dobMonth, dobYear, tobHour, tobMin;

  AddRelativeEvent(
      this.firstName,
      this.lastName,
      this.gender,
      this.place,
      this.relationNames,
      this.dobDay,
      this.dobMonth,
      this.dobYear,
      this.tobHour,
      this.tobMin,
      this.meridiem);
}

class UpdateRelativeEvent extends MyProfileEvent {
  final String firstName, lastName, gender, meridiem, uuid;
  final Place place;
  final RelationNames relationNames;
  final int dobDay, dobMonth, dobYear, tobHour, tobMin;

  UpdateRelativeEvent(
      this.uuid,
      this.firstName,
      this.lastName,
      this.gender,
      this.place,
      this.relationNames,
      this.dobDay,
      this.dobMonth,
      this.dobYear,
      this.tobHour,
      this.tobMin,
      this.meridiem);
}
