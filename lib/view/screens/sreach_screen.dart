import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news/componante/article_componate/article_componate.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import 'package:news/view_model/Cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/componante/componante.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter/services.dart';

class SreachScreen extends StatefulWidget {
  @override
  State<SreachScreen> createState() => _SreachScreenState();
}
  final TextEditingController _controller = TextEditingController();

class _SreachScreenState extends State<SreachScreen> {
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
        var list = NewsCubit.get(context).sreach;
        return Scaffold(
            // backgroun
            //dColor:Theme.of(context).textTheme.bodyText1.color,
            // appBar: AppBar(),
            body: Column(
              
                  children: [
                    SizedBox(
height: 7.h,
                    ),
  
                            
        
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text_Form_Widget(
                      controller: _controller ,
                        lableText: "Sreach".tr(),
                        hintText: "Sreach".tr(),
                       
                        prefixIcon: Icon(Icons.search),
                        onTap: () {},
                        onChanged: (value) {
                          NewsCubit.get(context).getSreach(value);
                         
                        },
                      ),
                    ),
                     if(_controller.text.isNotEmpty)
                    Expanded(
                      child: articleBuilder(list, context, isSreach: true),
                    ),
                  ],
                ),
            );
      },
    );
  }
}
 

 