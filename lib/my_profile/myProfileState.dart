import 'package:equatable/equatable.dart';
import 'package:india_today_assignment/models/place.dart';
import 'package:india_today_assignment/models/relation_names.dart';
import 'package:india_today_assignment/models/relative.dart';

abstract class MyProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class IdleState extends MyProfileState {}

class TabChangedState extends MyProfileState {
  final int index;

  TabChangedState(this.index);
}

class FetchingRelativesState extends MyProfileState {}

class RelativesFetchedState extends MyProfileState {
  final List<Relative> relatives;

  RelativesFetchedState(this.relatives);
}

class RelativesFetchFailedState extends MyProfileState {
  final String reason;

  RelativesFetchFailedState(this.reason);
}

class NewProfileAddingState extends MyProfileState {
  final bool isAdding;
  final Relative? relative;
  NewProfileAddingState(this.isAdding, {this.relative});
}
class PlacesFetchedState extends MyProfileState {
  final List<Place> places;

  PlacesFetchedState(this.places);
}

class GenderChangedState extends MyProfileState{
  final String gender;
  GenderChangedState(this.gender);
}
class MeridiemChangedState extends MyProfileState{
  final String meridiem;
  MeridiemChangedState(this.meridiem);
}
class RelationChangedState extends MyProfileState{
  final RelationNames relation;
  RelationChangedState(this.relation);
}
class SavingRelationState extends MyProfileState {}
class RelationSavedState extends MyProfileState {}
class RelationSaveFailedState extends MyProfileState {
  final String reason;
  RelationSaveFailedState(this.reason);
}

class RelativeDeletedState extends  MyProfileState {}
class RelativeDeleteFailedState extends  MyProfileState {
  final String reason;
  RelativeDeleteFailedState(this.reason);
}