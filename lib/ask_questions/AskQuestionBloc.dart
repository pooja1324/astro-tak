import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:india_today_assignment/api_calls/api_calls.dart';
import 'package:india_today_assignment/ask_questions/AskQuestionEvent.dart';
import 'package:india_today_assignment/ask_questions/AskQuestionState.dart';
import 'package:india_today_assignment/models/category.dart';

class AskQuestionBloc extends Bloc<AskQuestionEvent, AskQuestionState> {
  List<Category> categories = [];

  AskQuestionBloc() : super(IdleState()) {
    on<FetchCategoriesEvent>((event, emit) async {
      emit(FetchingCategoriesState());
      try {
        String response = await ApiCalls.fetchCategories();
        Map<String, dynamic> parsedResponse = json.decode(response);
        if (parsedResponse['httpStatusCode'] == 200) {
          for (var value in (parsedResponse['data'] as List<dynamic>)) {
            categories.add(Category.fromJson(value as Map<String, dynamic>));
          }
          emit(CategoriesFetchedState(categories, categories.first));
          emit(IdleState());
        } else {
          emit(CategoriesFetchFailedState('Something went wrong!!!'));
        }
      } catch (e) {
        emit(CategoriesFetchFailedState(e.toString()));
      }
    });

    on<CategorySelectionChangedEvent>((event, emit) {
      emit(CategoriesFetchedState(categories, event.category));
      emit(IdleState());
    });

  }
}
