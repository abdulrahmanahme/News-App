import 'package:flutter/material.dart';
import 'package:news/componante/article_componate/article_componate.dart';
import 'package:news/componante/image_slider_component/image_slider_component.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view_model/Cubit/states.dart';
import 'package:news/view/screens/sreach_screen.dart';
import 'package:news/view/screens/webveiw_screen.dart';
import 'package:news/componante/componante.dart';
import 'package:news/view_model/server/local/sharedpre.dart';
import 'package:news/view_model/server/local/data_base.dart';
import 'package:news/view_model/server/remote/network_exceptions/network_exceptions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news/model/artical_model_db.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  final refreshKey= GlobalKey<RefreshIndicatorState> ();

class _HomeScreenState extends State<HomeScreen> {
  int index;
    
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>( 
      listener: (context, state) {
        if (state is NewsGetSportsErrorState  ) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BuildForErrorWidget(
                        errorResult: state.error.message,
                        image: state.error.image,
                      )));
        }
      },
      builder: (context, state) {
        NewsCubit.get(context).getBusiness(CacheService.lange);
        NewsCubit.get(context).getscience(CacheService.lange);
        NewsCubit.get(context).getsports(CacheService.lange);
        NewsCubit.get(context).getTopHeadlines(CacheService.lange);
        NewsCubit.get(context).gethealth(CacheService.lange);
        NewsCubit.get(context).getEntertainment(CacheService.lange);
        NewsCubit.get(context).getTechnology(CacheService.lange);

        var cubit = NewsCubit.get(context);
        return DefaultTabController(
            length: 5,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body:   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                      height: 1.h,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Trending Topics".tr(),
                              style: TextStyle(
                                fontSize: 1.5.pc,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: Device.orientation == Orientation.portrait
                            ? 30.h
                            : 30.h,
                        width: Device.orientation == Orientation.portrait
                            ? 100.w
                            : 90.w,
                        child: Expanded(
                            child:
                                buildImageSlider(context, cubit.tobHeadline)),
                      ),
                     
                      TabBar(
                        // indicator: BoxDecoration(
                        //   color: Colors.grey.shade100,
                        //   border: Border.all(
                        //     color: Colors.green,
                        //     width: 3,
                        //   ),
                        //   borderRadius: BorderRadius.all(Radius.circular(12) //
                        //       ),
                        // ),
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        isScrollable: true,
                        labelColor: Theme.of(context).textTheme.bodyText1.color,
                        unselectedLabelColor: Colors.grey,
                        indicatorWeight: 2,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colors.grey,
                        unselectedLabelStyle: TextStyle(fontSize: 20),
                        tabs: [
                          Tab(
                            child: Text('Today'.tr()),
                          ),
                          Tab(
                            child: Text('Sports'.tr()),
                          ),
                          Tab(
                            child: Text('Health'.tr()),
                          ),
                          Tab(
                            child: Text('Technology'.tr()),
                          ),
                          Tab(
                            child: Text('Entertainment'.tr()),
                          ),
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                        // physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ConditionalBuilder(
                            condition: cubit.tobHeadline.length > 0,
                            builder: (context) => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => ArtcialCard(
                               
                                      article: cubit.tobHeadline[index],
                                      colorCategory: Colors.orange,
                                      nameCategory: 'Today'.tr(),
                                    ),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 1.h,
                                  );
                                },
                                itemCount: cubit.tobHeadline.length
                                
                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          ConditionalBuilder(
                            condition: cubit.sports.length > 0,
                            builder: (context) => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>ArtcialCard(
                                 
                                      colorCategory: Colors.green,
                                      nameCategory: 'Sports'.tr(),
                                      article: cubit.sports[index],
                                    ),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 1.h,
                                  );
                                },
                                // itemCount: cubit.sports.length
                                itemCount: cubit.sports.length,
                                

                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          ConditionalBuilder(
                            condition: cubit.health.length > 0,
                            builder: (context) => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => ArtcialCard(
                                
                                      article: cubit.health[index],
                                      colorCategory: Colors.blueGrey[800],
                                      nameCategory: 'Health'.tr(),
                                    ),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 1.h,
                                  );
                                },
                                itemCount: cubit.health.length
                               

                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          ConditionalBuilder(
                            condition: cubit.technology.length > 0,
                            builder: (context) => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>  ArtcialCard(
                                  
                                      article: cubit.technology[index],
                                      colorCategory: Colors.pink[900],
                                      nameCategory: 'Technology'.tr(),
                                    ),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 1.h,
                                  );
                                },
                                itemCount: cubit.technology.length
                               

                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          ConditionalBuilder(
                            condition: cubit.entertainment.length > 0,
                            builder: (context) => ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => ArtcialCard(
                                   
                                      article: cubit.entertainment[index],
                                      colorCategory:
                                          Color.fromARGB(255, 67, 14, 136),
                                      nameCategory: 'Entertainment'.tr(),
                                    ),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 1.h,
                                  );
                                },
                                itemCount: cubit.entertainment.length
                                

                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ))
                    ],
                  ),
            
            ));
      },
    );
  }
}
