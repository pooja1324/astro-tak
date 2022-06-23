import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_today_assignment/colors.dart';
import 'package:india_today_assignment/models/place.dart';
import 'package:india_today_assignment/models/relation_names.dart';
import 'package:india_today_assignment/models/relative.dart';
import 'package:india_today_assignment/my_profile/myProfileBloc.dart';
import 'package:india_today_assignment/my_profile/myProfileEvent.dart';
import 'package:india_today_assignment/my_profile/myProfileState.dart';

class AddProfileScreen extends StatefulWidget {
  final Relative? relative;
  const AddProfileScreen({this.relative,Key? key}) : super(key: key);

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  MyProfileBloc? _bloc;
  List<Place> places = [];
  final _formKey = GlobalKey<FormState>();

  late TextStyle labelStyle;
  List<String> gender = ['MALE', 'FEMALE'];

  String selectedGender = 'MALE';
  late RelationNames selectedRelation;
  Place? selectedPlace;
  String meridiem='AM';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobDDController = TextEditingController();
  final TextEditingController _dobMMController = TextEditingController();
  final TextEditingController _dobYYYYController = TextEditingController();
  final TextEditingController _tobHHController = TextEditingController();
  final TextEditingController _tobMMController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRelation = relations.first;
    labelStyle = TextStyle(
        color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.w300);
    print(widget.relative);
    if(widget.relative!=null){
      _nameController.text=widget.relative!.firstName+' '+widget.relative!.lastName;
      _dobDDController.text=widget.relative!.dobDay.toString();
      _dobMMController.text=widget.relative!.dobMonth.toString();
      _dobYYYYController.text=widget.relative!.dobYear.toString();
      _tobHHController.text=widget.relative!.tobHour.toString();
      _tobMMController.text=widget.relative!.tobMin.toString();
      meridiem=widget.relative!.meridiem;
      selectedPlace=widget.relative!.place;
      selectedRelation=widget.relative!.relationNames;
      selectedGender=widget.relative!.gender;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<MyProfileBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyProfileBloc,MyProfileState> (
      listener: (context, state) {
        if(state is RelationSavedState){
          onBackPressed();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile Saved')),
          );
        }
      },
      child: Expanded(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: onBackPressed,
                    label: const Text(
                      'Add New Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    )),
              ),
              Text(
                'Name',
                style: labelStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.split(' ').length < 2) {
                    return 'Enter valid Name';
                  }
                  return null;
                },
                controller: _nameController,
                cursorColor: Colors.blue,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Date of Birth',
                style: labelStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) > 31) {
                        return 'Invalid DD';
                      }
                      return null;
                    },
                    controller: _dobDDController,
                    maxLength: 2,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) > 12) {
                        return 'Invalid MM';
                      }
                      return null;
                    },
                    controller: _dobMMController,
                    maxLength: 2,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) > 2022) {
                        return 'Invalid YYYY';
                      }
                      return null;
                    },
                    controller: _dobYYYYController,
                    maxLength: 4,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Time of Birth',
                style: labelStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) > 12) {
                        return 'Invalid HH';
                      }
                      return null;
                    },
                    controller: _tobHHController,
                    maxLength: 2,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) > 60) {
                        return 'Invalid MM';
                      }
                      return null;
                    },
                    controller: _tobMMController,
                    maxLength: 2,
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(child:  BlocBuilder<MyProfileBloc, MyProfileState>(
                      buildWhen: (_, currentState) =>
                      currentState is MeridiemChangedState,
                      builder: (context, state) {
                        if (state is MeridiemChangedState) {
                          meridiem = state.meridiem;
                        }
                        return TimeSelection(meridiem, (changedMeridiem) {
                          _bloc?.add(MeridiemChangedEvent(changedMeridiem));
                        });
                    }
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Place of Birth',
                style: labelStyle,
              ),
              const SizedBox(
                height: 4,
              ),
              BlocBuilder<MyProfileBloc, MyProfileState>(
                  buildWhen: (_, currentState) =>
                      currentState is PlacesFetchedState,
                  builder: (context, state) {
                    if (state is PlacesFetchedState) {
                      places = state.places;
                    }
                    return Autocomplete<Place>(
                      // fieldViewBuilder: (context, textEditingController, focusNode,
                      //     onFieldSubmitted) {
                      //   return TextField(
                      //     controller: textEditingController,
                      //     cursorColor: Colors.blue,
                      //     keyboardType: TextInputType.text,
                      //     decoration: const InputDecoration(
                      //         border: OutlineInputBorder(),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(color: Colors.blue))),
                      //   );
                      // },
                      initialValue: TextEditingValue(text: selectedPlace?.name??''),
                      optionsMaxHeight: 200,
                      displayStringForOption: (place) => place.name,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<Place>.empty();
                        }
                        _bloc?.add(PlaceSearchEvent(textEditingValue.text));
                        return places;
                      },
                      onSelected: (Place selection) {
                        selectedPlace = selection;
                      },
                    );
                  }),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gender',
                          style: labelStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        BlocBuilder<MyProfileBloc, MyProfileState>(
                            buildWhen: (_, currentState) =>
                                currentState is GenderChangedState,
                            builder: (context, state) {
                              if (state is GenderChangedState) {
                                selectedGender = state.gender;
                              }
                              return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 12, right: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  filled: false,
                                ),
                                items: gender.map((String s) {
                                  return DropdownMenuItem<String>(
                                    value: s,
                                    child: Text(s),
                                  );
                                }).toList(),
                                onChanged: (s) {
                                  _bloc?.add(GenderChangedEvent(s!));
                                },
                                value: selectedGender,
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Relation',
                          style: labelStyle,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        BlocBuilder<MyProfileBloc, MyProfileState>(
                            buildWhen: (_, currentState) =>
                                currentState is RelationChangedState,
                            builder: (context, state) {
                              if (state is RelationChangedState) {
                                selectedRelation = state.relation;
                              }
                              return DropdownButtonFormField<RelationNames>(
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 12, right: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  filled: false,
                                ),
                                items: relations.map((relation) {
                                  return DropdownMenuItem<RelationNames>(
                                    value: relation,
                                    child: Text(relation.name),
                                  );
                                }).toList(),
                                onChanged: (s) {
                                  _bloc?.add(RelationChangedEvent(s!));
                                },
                                value: selectedRelation,
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<MyProfileBloc, MyProfileState>(
                    buildWhen: (_, currentState) =>
                    currentState is SavingRelationState || currentState is RelationSavedState,
                    builder: (context, state) {
                      if (state is SavingRelationState) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: onSaveTapped,
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        ));
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSaveTapped() {
    if (_formKey.currentState!.validate() && selectedPlace != null) {
      if (widget.relative != null) {
        _bloc?.add(UpdateRelativeEvent(
          widget.relative!.uuid,
          _nameController.text
              .split(' ')
              .first,
          _nameController.text
              .split(' ')
              .last,
          selectedGender,
          selectedPlace!,
          selectedRelation,
          int.parse(_dobDDController.text),
          int.parse(_dobMMController.text),
          int.parse(_dobYYYYController.text),
          int.parse(_tobHHController.text),
          int.parse(_tobMMController.text),
          meridiem,
        ));
      } else {
        _bloc?.add(AddRelativeEvent(
          _nameController.text
              .split(' ')
              .first,
          _nameController.text
              .split(' ')
              .last,
          selectedGender,
          selectedPlace!,
          selectedRelation,
          int.parse(_dobDDController.text),
          int.parse(_dobMMController.text),
          int.parse(_dobYYYYController.text),
          int.parse(_tobHHController.text),
          int.parse(_tobMMController.text),
          meridiem,
        ));
      }
    }
  }

  void onBackPressed() {
    _bloc?.add(NewProfileAddingEvent(false));
  }
}

class TimeSelection extends StatelessWidget {
  final String meridiem;
  final Function(String) onTabChanged;

  const TimeSelection(this.meridiem, this.onTabChanged, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                  color: meridiem == 'AM' ? blueColor : Colors.white,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  'AM',
                  style: TextStyle(
                      color: meridiem == 'AM' ? Colors.white : Colors.black),
                ),
              ),
            ),
            onTap: () {
              onTabChanged('AM');
            },
          ),
        ),
        Expanded(
          child: InkWell(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                  color: meridiem == 'PM' ? blueColor : Colors.white,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  'PM',
                  style: TextStyle(
                      color: meridiem == 'PM' ? Colors.white : Colors.black),
                ),
              ),
            ),
            onTap: () {
              onTabChanged('PM');
            },
          ),
        ),
      ],
    );
  }
}
