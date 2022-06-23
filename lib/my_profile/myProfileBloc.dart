import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:india_today_assignment/api_calls/api_calls.dart';
import 'package:india_today_assignment/models/place.dart';
import 'package:india_today_assignment/models/relative.dart';
import 'package:india_today_assignment/my_profile/myProfileEvent.dart';
import 'package:india_today_assignment/my_profile/myProfileState.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(IdleState()) {
    on<TabChangeEvent>((event, emit) {
      emit(TabChangedState(event.index));
      emit(IdleState());
    });
    on<FetchRelativesEvent>((event, emit) async {
      emit(FetchingRelativesState());
      try {
        String response = await ApiCalls.fetchRelatives();
        Map<String, dynamic> parsedResponse = json.decode(response);
        if (parsedResponse['httpStatusCode'] == 200) {
          List<Relative> relatives = [];
          for (var value in (parsedResponse['data']['allRelatives'] as List<dynamic>)) {
            relatives.add(Relative.fromJson(value as Map<String, dynamic>));
          }
          emit(RelativesFetchedState(
            relatives,
          ));
          emit(IdleState());
        } else {
          emit(RelativesFetchFailedState('Something went wrong!!!'));
        }
      } catch (e) {
        emit(RelativesFetchFailedState(e.toString()));
      }
    });
    on<NewProfileAddingEvent>((event, emit) {
      emit(NewProfileAddingState(event.isAdding, relative: event.relative));
      emit(IdleState());
    });
    on<GenderChangedEvent>((event, emit) {
      emit(GenderChangedState(event.gender));
      emit(IdleState());
    });
    on<RelationChangedEvent>((event, emit) {
      emit(RelationChangedState(event.relation));
      emit(IdleState());
    });
    on<MeridiemChangedEvent>((event, emit) {
      emit(MeridiemChangedState(event.meridiem));
      emit(IdleState());
    });
    on<PlaceSearchEvent>((event, emit) async {
      try {
        String response = await ApiCalls.fetchPlaces(event.search);
        Map<String, dynamic> parsedResponse = json.decode(response);
        if (parsedResponse['httpStatusCode'] == 200) {
          List<Place> places = [];
          for (var value in (parsedResponse['data'] as List<dynamic>)) {
            places.add(Place.fromJson(value as Map<String, dynamic>));
          }
          emit(PlacesFetchedState(
            places,
          ));
          emit(IdleState());
        }
      } catch (e) {
        print(e);
      }
    });
    on<AddRelativeEvent>((event, emit) async {
      emit(SavingRelationState());
      try {
        String response = await ApiCalls.addRelative({
          'birthDetails': {
            "dobDay": event.dobDay,
            "dobMonth": event.dobMonth,
            "dobYear": event.dobYear,
            "tobHour": event.tobHour,
            "tobMin": event.tobMin,
            "meridiem": event.meridiem,
          },
          'birthPlace': {
            "placeName": event.place.name,
            "placeId": event.place.id,
          },
          "firstName": event.firstName,
          "lastName": event.lastName,
          "relationId": event.relationNames.id,
          "gender": event.gender
        });
        Map<String, dynamic> parsedResponse = json.decode(response);
        if (parsedResponse['httpStatusCode'] == 200) {
          emit(RelationSavedState());
          emit(IdleState());
          add(FetchRelativesEvent());
        }
      } catch (e) {
        emit(RelationSaveFailedState(e.toString()));
      }
    });
    on<UpdateRelativeEvent>((event, emit) async {
      emit(SavingRelationState());
      try {
        String response = await ApiCalls.updateRelative({
          'uuid':event.uuid,
          'birthDetails': {
            "dobDay": event.dobDay,
            "dobMonth": event.dobMonth,
            "dobYear": event.dobYear,
            "tobHour": event.tobHour,
            "tobMin": event.tobMin,
            "meridiem": event.meridiem,
          },
          'birthPlace': {
            "placeName": event.place.name,
            "placeId": event.place.id,
          },
          "firstName": event.firstName,
          "lastName": event.lastName,
          "relationId": event.relationNames.id,
          "gender": event.gender
        });
        Map<String, dynamic> parsedResponse = json.decode(response);
        if (parsedResponse['httpStatusCode'] == 200) {
          emit(RelationSavedState());
          emit(IdleState());
          add(FetchRelativesEvent());
        }
      } catch (e) {
        emit(RelationSaveFailedState(e.toString()));
      }
    });
    on<DeleteRelativeEvent>((event, emit) async{
      try{
        String response = await ApiCalls.deleteRelative(event.relative.uuid);
        print(response);
        Map<String, dynamic> parsedResponse = json.decode(response);
        if (parsedResponse['httpStatusCode'] == 200) {
          emit(RelativeDeletedState());
          emit(IdleState());
          add(FetchRelativesEvent());
        }
      }catch(e){
        print(e);

        emit(RelativeDeleteFailedState(e.toString()));
      }
    });
  }
}
