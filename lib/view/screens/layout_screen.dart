import 'package:flutter/material.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view_model/Cubit/states.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../componante/article_componate/widgets/widgets.dart';
import '../../componante/componante.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.counter],),
            
            elevation: 1,
          ),
          body: cubit.newsboy[cubit.counter],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.red,
            elevation: 20.0,
            items: cubit.itemsBottom,
            currentIndex: cubit.counter,
            onTap: (int index) {
              cubit.bottomBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
