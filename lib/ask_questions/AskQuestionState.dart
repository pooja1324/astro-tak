import 'package:equatable/equatable.dart';
import 'package:india_today_assignment/models/category.dart';

abstract class AskQuestionState extends Equatable {
  @override
  List<Object> get props => [];
}

class IdleState extends AskQuestionState {}
class CategoriesFetchedState extends AskQuestionState {
  final List<Category> categories;
  final Category selectedCategory;
  CategoriesFetchedState(this.categories,this.selectedCategory);
}
class FetchingCategoriesState extends AskQuestionState{}
class CategoriesFetchFailedState extends AskQuestionState{
  final String reason;
  CategoriesFetchFailedState(this.reason);
}