import 'package:flutter/material.dart';
import 'package:news/Cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Modules/Modules_business.dart';
import 'package:news/Modules/Modules_science.dart';
import 'package:news/Modules/Modules_sport.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/componante/sharedpre.dart';
import 'package:news/network/remote/Dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(IntialStates());
  static NewsCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void bottomBarIndex(int index) {
    counter = index;

    if (index == 1) getsports();
    if (index == 2) getBusiness();

    emit(BottomBarIndexState());
  }

  bool isDark = false;
  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeState());
    } else {
      isDark = !isDark;

      CacheHelper.putBoolen(key: 'isDart', value: isDark).then((value) {});
      emit(ChangeAppModeState());
    }
  }

  var newbody = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> itemsBottom = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
      backgroundColor: Colors.grey,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
      backgroundColor: Colors.grey,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
      backgroundColor: Colors.grey,
    ),
  ];

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLoadingBusinessState());

    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": "us",
      "category": "business",
      "apiKey": "a4e6e8ceaa904626a864face924fdd60",
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);

      emit(GetBusinessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error: error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getsports() {
    emit(NewsLoadingSportsState());
    if (sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "sports",
        "apiKey": "a4e6e8ceaa904626a864face924fdd60",
      }).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(GetSportsDataState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error: error.toString()));
      });
    } else {
      emit(GetSportsDataState());
    }
  }

  List<dynamic> science = [];
  void getscience() {
    emit(NewsGetLoadingSciencState());
    if (science.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": "us",
        "category": "science",
        "apiKey": "a4e6e8ceaa904626a864face924fdd60",
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceDataState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSciencErrorState(error: error.toString()));
      });
    } else {
      emit(NewsGetScienceDataState());
    }
  }

  // https://newsapi.org/v2/everything?q=tesla&from=2021-04-29&sortBy=publishedAt&apiKey=a4e6e8ceaa904626a864face924fdd60
  List<dynamic> sreach = [];

  void getSreach(String value) {
    emit(NewsGetLoadingsreachState());

    DioHelper.getData(url: 'v2/everything', query: {
      "q": "$value",
      "apiKey": "a4e6e8ceaa904626a864face924fdd60",
    }).then((value) {
      sreach = value.data['articles'];
      print(sreach[0]['title']);
      emit(NewsGetsreachDataState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetsreachErrorState(error: error.toString()));
    });
  }
}
