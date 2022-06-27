import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/dropdown_cubit.dart';
import 'package:pixlog_challenge/app/modules/i18n_resources/ui/bloc/dropdown_state.dart';

class FilterDropdownMenu extends StatelessWidget {
  final String value;
  final List<String> items;
  final Bloc bloc;
  final String text;
  final Function onChanged;

  const FilterDropdownMenu({
    Key? key,
    required this.value,
    required this.items,
    required this.bloc,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<DropdownValueCubit>();
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<DropdownValueCubit, DropdownState>(
      bloc: cubit,
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * .1, right: 20, top: 20, bottom: 20),
            child: Text(text),
          ),
          DropdownButton(
            value: (value == "") ? items.first : value,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? val) => onChanged(val),
          ),
        ],
      ),
    );
  }
}
