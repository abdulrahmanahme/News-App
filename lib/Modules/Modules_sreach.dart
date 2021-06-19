import 'package:flutter/material.dart';
import 'package:news/Cubit/cubit.dart';
import 'package:news/Cubit/states.dart';
import 'package:news/componante/Text_form_filed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/componante/componante.dart';

class SreachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sreach;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text_Form_Widget(
                  lableText: "Sreach",
                  hintText: "Sreach",
                  prefixIcon: Icon(Icons.search),
                  onTap: () {},
                  onChanged: (value) {
                    NewsCubit.get(context).getSreach(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(list, isSreach: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
