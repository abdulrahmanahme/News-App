import 'package:flutter/material.dart';
import 'package:news/componante/article_componate/article_componate.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import 'package:news/view_model/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/componante/componante.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text_Form_Widget(
                  controller: context.read<NewsCubit>().controller,
                  hintText: "Search".tr(),
                  prefixIcon: Icon(Icons.search,color: Colors.black38,),
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              if (context.read<NewsCubit>().controller.text.isNotEmpty)
                Expanded(
                  child: ArticleBuilder(list, context, isSearch: true),
                ),
            ],
          ),
        );
      },
    );
  }
}
