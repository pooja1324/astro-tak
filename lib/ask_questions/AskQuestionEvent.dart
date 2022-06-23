import 'package:equatable/equatable.dart';
import 'package:india_today_assignment/models/category.dart';

abstract class AskQuestionEvent extends Equatable {
  const AskQuestionEvent();
  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends AskQuestionEvent{}
class CategorySelectionChangedEvent extends AskQuestionEvent {
  final Category category;
  const CategorySelectionChangedEvent(this.category);
}