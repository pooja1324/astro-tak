import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_today_assignment/colors.dart';
import 'package:india_today_assignment/models/relative.dart';
import 'package:india_today_assignment/my_profile/addProfileSreen.dart';
import 'package:india_today_assignment/my_profile/myProfileBloc.dart';
import 'package:india_today_assignment/my_profile/myProfileEvent.dart';
import 'package:india_today_assignment/my_profile/myProfileState.dart';

class MyProfileTab extends StatefulWidget {
  const MyProfileTab({Key? key}) : super(key: key);

  @override
  State<MyProfileTab> createState() => _MyProfileTabState();
}

class _MyProfileTabState extends State<MyProfileTab> {
  int tabIndex = 1;
  bool isNewAdding = false;
  Relative? updatingRelative;
  List<Relative> relatives = [];

  MyProfileBloc? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<MyProfileBloc>(context);
    _bloc?.add(FetchRelativesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<MyProfileBloc, MyProfileState>(
          buildWhen: (prevState, currentState) =>
              currentState is TabChangedState ||
              currentState is NewProfileAddingState ||
              currentState is RelativesFetchedState,
          builder: (context, state) {
            if (state is TabChangedState) {
              tabIndex = state.index;
            }
            if (state is NewProfileAddingState) {
              isNewAdding = state.isAdding;

              print(state.relative);
              updatingRelative = state.relative;
            }
            if (state is RelativesFetchedState) {
              relatives = state.relatives;
            }
            return Column(
              children: [
                ProfileSelectionHeader(tabIndex, onTabChanged),
                const SizedBox(height: 16),
                isNewAdding
                    ? AddProfileScreen(
                        relative: updatingRelative,
                      )
                    : Expanded(
                      child: Column(
                          children: [
                            const WalletBalanceWidget(),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: relatives.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      TextStyle headerTextStyle = const TextStyle(
                                          color: blueColor, fontSize: 16);
                                      return Row(
                                        children: [
                                          Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Name',
                                                style: headerTextStyle,
                                              )),
                                          Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'DOB',
                                                style: headerTextStyle,
                                              )),
                                          Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'TOB',
                                                style: headerTextStyle,
                                              )),
                                          Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                'Relation',
                                                style: headerTextStyle,
                                              )),
                                          const Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text('')),
                                          const Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text('')),
                                        ],
                                      );
                                    }
                                    Relative relative = relatives[index - 1];
                                    return Container(
                                      margin:
                                          const EdgeInsets.symmetric(vertical: 8),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 1.0,
                                            ),
                                          ]),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 4),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                  '${relative.firstName} ${relative.lastName}')),
                                          Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                  '${relative.dobDay}-${relative.dobMonth}-${relative.dobYear}')),
                                          Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                  '${relative.tobHour}:${relative.tobMin} ${relative.meridiem}')),
                                          Flexible(
                                            flex: 2,
                                            fit: FlexFit.tight,
                                            child:
                                                Text(relative.relationNames.name),
                                          ),
                                          Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: orangeColor,
                                                ),
                                                onPressed: () {
                                                  _bloc?.add(NewProfileAddingEvent(
                                                      true,
                                                      relative: relative));
                                                },
                                              )),
                                          Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize.min,
                                                              children: [
                                                                const Text(
                                                                  'Do you really want to Delete?',
                                                                  style: TextStyle(
                                                                      fontSize: 16),
                                                                ),
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          _bloc?.add(
                                                                              DeleteRelativeEvent(
                                                                                  relative));
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'YES',
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .white,
                                                                              fontSize:
                                                                                  16),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 16,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'NO',
                                                                            style: TextStyle(
                                                                                color:
                                                                                    Colors.white,
                                                                                fontSize: 16)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              )),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: onAddProfileTapped,
                                label: const Text(
                                  'Add New Profile',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                    ),
              ],
            );
          }),
    );
  }

  void onAddProfileTapped() {
    _bloc?.add(NewProfileAddingEvent(true));
  }

  void onTabChanged(int index) {
    _bloc?.add(TabChangeEvent(index));
  }
}

class ProfileSelectionHeader extends StatelessWidget {
  final int tabIndex;
  final Function(int) onTabChanged;

  const ProfileSelectionHeader(this.tabIndex, this.onTabChanged, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: tabIndex == 0 ? orangeColor : Colors.white,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  'Basic Profile',
                  style: TextStyle(
                      color: tabIndex == 0 ? Colors.white : Colors.black),
                ),
              ),
            ),
            onTap: () {
              onTabChanged(0);
            },
          ),
        ),
        Expanded(
          child: InkWell(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: tabIndex == 1 ? orangeColor : Colors.white,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  'Friends and family Profile',
                  style: TextStyle(
                      color: tabIndex == 1 ? Colors.white : Colors.black),
                ),
              ),
            ),
            onTap: () {
              onTabChanged(1);
            },
          ),
        ),
      ],
    );
  }
}

class WalletBalanceWidget extends StatelessWidget {
  const WalletBalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: lightBlueColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset(
                'images/home.png',
                color: blueColor,
                height: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              const Text(
                'Wallet Balance: ₹ 0',
                style: TextStyle(color: blueColor),
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                height: 32,
                child: OutlinedButton(
                  onPressed: onAddMoneyPressed,
                  child: const Text(
                    'Add Money',
                    style: TextStyle(color: blueColor),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void onAddMoneyPressed() {}
}
