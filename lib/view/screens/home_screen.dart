import 'package:flutter/material.dart';
import 'package:news/componante/article_componate/article_componate.dart';
import 'package:news/componante/image_slider_component/image_slider_component.dart';
import 'package:news/view/screens/layout_screen.dart';
import 'package:news/view_model/Cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view_model/Cubit/states.dart';
import 'package:news/view/screens/sreach_screen.dart';
import 'package:news/view/screens/webveiw_screen.dart';
import 'package:news/componante/componante.dart';
import 'package:news/view_model/server/local/sharedpre.dart';

import 'package:news/view_model/server/remote/network_exceptions/network_exceptions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final refreshKey = GlobalKey<RefreshIndicatorState>();

class _HomeScreenState extends State<HomeScreen> {
  int index;
  @override
  void initState() {
    NewsCubit.get(context).getBusiness(CacheService.lange);
    NewsCubit.get(context).getscience(CacheService.lange);
    NewsCubit.get(context).getsports(CacheService.lange);
    NewsCubit.get(context).getTopHeadlines(CacheService.lange);
    NewsCubit.get(context).gethealth(CacheService.lange);
    NewsCubit.get(context).getEntertainment(CacheService.lange);
    NewsCubit.get(context).getTechnology(CacheService.lange);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {
        if (state is NewsGetBusinessErrorState) {
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
        var cubit = NewsCubit.get(context);
        return DefaultTabController(
            length: 5,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TabBar(
                    labelStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    isScrollable: true,
                    labelColor: Theme.of(context).textTheme.bodyText1.color,
                    unselectedLabelColor: Colors.grey,
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.grey,
                    unselectedLabelStyle: TextStyle(fontSize: 15.sp),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                            ),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => ArticleCard(
                                  article: cubit.tobHeadline[index],
                                  colorCategory: Colors.orange,
                                  nameCategory: 'Today'.tr(),
                                ),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 1.h,
                              );
                            },
                            itemCount: cubit.tobHeadline.length),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      ConditionalBuilder(
                        condition: cubit.sports.length > 0,
                        builder: (context) => ListView.separated(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                          ),

                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => ArticleCard(
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                            ),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => ArticleCard(
                                  article: cubit.health[index],
                                  colorCategory: Colors.blueGrey[800],
                                  nameCategory: 'Health'.tr(),
                                ),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 1.h,
                              );
                            },
                            itemCount: cubit.health.length),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      ConditionalBuilder(
                        condition: cubit.technology.length > 0,
                        builder: (context) => ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                            ),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => ArticleCard(
                                  article: cubit.technology[index],
                                  colorCategory: Colors.pink[900],
                                  nameCategory: 'Technology'.tr(),
                                ),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 1.h,
                              );
                            },
                            itemCount: cubit.technology.length),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      ConditionalBuilder(
                        condition: cubit.entertainment.length > 0,
                        builder: (context) => ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                            ),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => ArticleCard(
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
                            itemCount: cubit.entertainment.length),
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

class errorWidget extends StatelessWidget {
  errorWidget({
    this.image,
    this.error,
    Key key,
  }) : super(key: key);
  String image;
  String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          // image ?? 'assets/images/bad_request_error.png',
          image,
          //  errorResult.
          height: 200.0,
          width: 200.0,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Text(
            error,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: 22.0,
              height: 1,
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.blueGrey.shade900,
            primary: Colors.blueAccent,
            padding:
                const EdgeInsets.only(top: 10, bottom: 15, left: 50, right: 50),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Try Again'.tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LayoutScreen()));
          },
        ),
      ],
    );
  }
}
