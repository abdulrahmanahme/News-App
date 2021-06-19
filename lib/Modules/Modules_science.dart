import 'package:flutter/material.dart';

import 'package:news/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Cubit/states.dart';
import 'package:news/componante/componante.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).science;

          return articleBuilder(list);
        });
  }
}
