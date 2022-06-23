import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_today_assignment/ask_questions/AskQuestionBloc.dart';
import 'package:india_today_assignment/ask_questions/AskQuestionEvent.dart';
import 'package:india_today_assignment/ask_questions/AskQuestionState.dart';
import 'package:india_today_assignment/colors.dart';
import 'package:india_today_assignment/models/category.dart';

class AskQuestionScreen extends StatefulWidget {
  const AskQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AskQuestionScreen> createState() => AskQuestionScreenState();
}

class AskQuestionScreenState extends State<AskQuestionScreen> {
  AskQuestionBloc? _bloc;
  final TextEditingController _questionTextController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<AskQuestionBloc>(context);
    _bloc?.add(FetchCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset(
            'images/hamburger.png',
            height: 16,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Image.asset(
          'images/icon.png',
          height: 56,
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'images/profile.png',
              height: 24,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('profile');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: orangeColor,
      ),
      body: Column(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: blueColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wallet Balance : ₹0',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // This is what you need!
                    ),
                    onPressed: onAddMoneyButtonPressed,
                    child: const Text(
                      'Add Money',
                      style: TextStyle(color: blueColor),
                    ))
              ],
            ),
          ),
          BlocBuilder<AskQuestionBloc, AskQuestionState>(
              buildWhen: (prevState, currentState) =>
                  currentState is FetchingCategoriesState ||
                  currentState is CategoriesFetchFailedState ||
                  currentState is CategoriesFetchedState,
              builder: (context, state) {
                if (state is FetchingCategoriesState) {
                  return const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is CategoriesFetchFailedState) {
                  return Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(state.reason),
                    ),
                  );
                } else if (state is CategoriesFetchedState) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const Text(
                            'Ask a Question',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                              'Seek accurate answers to your life problems and guidance towards the right path. Whether the problem is related to love, self, life, business, money, education or work, our astrologers will do an in depth study of your birth chart to provide personalized responses along with remedies.'),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Choose Category',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<Category>(
                            items: state.categories.map((Category category) {
                              return DropdownMenuItem<Category>(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(),
                            onChanged: (category) {
                              _bloc?.add(
                                  CategorySelectionChangedEvent(category!));
                            },
                            value: state.selectedCategory,
                          ),
                          TextField(
                            controller: _questionTextController,
                            maxLength: 150,
                            minLines: 3,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Type a question here',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Ideas what to Ask (Select Any)',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                String ideaQuestion =
                                    state.selectedCategory.suggestions[index];
                                return Row(
                                  children: [
                                    Container(
                                      child: const Icon(
                                        Icons.question_mark,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      color: orangeColor,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(ideaQuestion),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount:
                                  state.selectedCategory.suggestions.length),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                              'Seeking accurate answers to difficult questions troubling your mind? Ask credible astrologers to know what future has in store for you.'),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: lightOrangeColor,
                            child: Column(
                              children: const [
                                Text(
                                  '● Personalized responses provided by our team of Vedic astrologers within 24 hours.',
                                  style: TextStyle(color: orangeColor),
                                ),
                                Text(
                                  '● Qualified and experienced astrologers will look into your birth chart abd provide right guidance.',
                                  style: TextStyle(color: orangeColor),
                                ),
                                Text(
                                  '● You can seek answers to any part of your life and for most pressing issues.',
                                  style: TextStyle(color: orangeColor),
                                ),
                                Text(
                                  '● Our team vedic astrologers will not just provide answers but also suggest a remedial solution.',
                                  style: TextStyle(color: orangeColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              })
        ],
      ),
    );
  }

  void onAddMoneyButtonPressed() {}
}
