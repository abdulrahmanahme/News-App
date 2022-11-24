import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news/componante/app_constaint.dart';
import 'package:news/view_model/Cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/view/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:news/view/screens/sreach_screen.dart';
import 'package:news/view/screens/home_screen.dart';
import 'package:news/view/screens/saved_artical_screen.dart';
import 'package:news/view_model/server/local/sharedpre.dart';
import 'package:news/view_model/server/local/data_base.dart';
import 'package:news/model/artical_model_db.dart';
import 'package:news/view_model/server/remote/network_exceptions/network_exceptions.dart';
import 'package:news/view_model/server/remote/Dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:news/view_model/server/local/sharedpre.dart';
import 'dart:io';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(IntialStates());
  static NewsCubit get(context) => BlocProvider.of(context);

  int counter = 0;
  int carouselSliderIndex = 0;

  void changeCarouselSliderIndex(int currentIndex) {
    carouselSliderIndex = currentIndex;
  }

  void bottomBarIndex(int index) {
    counter = index;

    if (index == 1) getsports(CacheService.lange);
    if (index == 2) getBusiness(CacheService.lange);

    emit(BottomBarIndexState());
  }

  bool isDark = false;

  void changeAppTheme({bool currentTheme, bool switchValue = true}) {
    if (currentTheme != null) {
      isDark = currentTheme;
      emit(ChangeAppModeState());
    } else {
      isDark = switchValue;
      CacheService.cacheData(key: 'Dark', value: isDark);

      emit(ChangedTODarkState());
    }
  }

  var title = [
    'Home'.tr(),
    'Search'.tr(),
    'Bookmark'.tr(),
    'Settings'.tr(),
  ];
  var newbody = [
    HomeScreen(),
    SreachScreen(),
    ArtcialSaved(),
    SettingView(),
  ];
  List<BottomNavigationBarItem> itemsBottom = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home'.tr(),
      backgroundColor: Colors.grey,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search'.tr(),
      backgroundColor: Colors.grey,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: 'Bookmark'.tr(),
      backgroundColor: Colors.grey,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings'.tr(),
      backgroundColor: Colors.grey,
    ),
  ];

// d2c6784d9ce6486dbaedb5cb5c736300   pro
// a0aff17d156844f39e4a8213faec276f       -- almamour
  // a4e6e8ceaa904626a864face924fdd60      -- abdo
  // 94f39739905c4a588a362c8f2f5c77ec
  List<dynamic> business = [];
  ////////////////////
  void getBusiness(String country) {
    emit(NewsLoadingBusinessState());
    if (translator.activeLanguageCode == 'ar') {
      country = 'eg';
    } else {
      country = 'us';
    }

    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": country,
      "category": "business",
      "apiKey": key,
    }).then((value) {
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(GetBusinessDataState());
    }).catchError((error) {
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      if (error is DioError) {
        emit(NewsGetBusinessErrorState(
            error: DioException.dioExceptionHandling(
                exceptionType: error.type, response: error.response)));
      }
    });
  }

  List<dynamic> tobHeadline = [];

  void getTopHeadlines(String country) {
    emit(NewsLoadingHeadlineState());
    if (translator.activeLanguageCode == 'ar') {
      country = 'eg';
    } else {
      country = 'us';
    }

    DioHelper.getData(url: "v2/top-headlines", query: {
      "country": country,
      "apiKey": key,
    }).then((value) {
      tobHeadline = value.data['articles'];

      emit(GetHeadlineDataState());
    }).catchError((error) {
        //  emit(NewsGetHeadlineErrorState());

      if (error is DioError) {
        emit(NewsGetHeadlineErrorState(
            error: DioException.dioExceptionHandling(
                exceptionType: error.type, response: error.response)));
      }
    });
  }

  List<dynamic> sports = [];
  void getsports(String country) {
    emit(NewsLoadingSportsState());
    if (translator.activeLanguageCode == 'ar') {
      country = 'eg';
    } else {
      country = 'us';
    }
    if (sports.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": country,
        "category": "sports",
        "apiKey": key,
      }).then((value) {
        sports = value.data['articles'];
        emit(GetSportsDataState());
      }).catchError((error) {
        if (error is DioError) {
          emit(NewsGetSportsErrorState(
              error: DioException.dioExceptionHandling(
                  exceptionType: error.type, response: error.response)
                  )
                  );
        }
      });
    }
  }

  List<dynamic> science = [];
  void getscience(String country) {
    emit(NewsGetLoadingSciencState());
    if (translator.activeLanguageCode == 'ar') {
      country = 'eg';
    } else {
      country = 'us';
    }
    if (science.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": country,
        "category": "science",
        "apiKey": key,
      }).then((value) {
        science = value.data['articles'];

        emit(NewsGetScienceDataState());
      }).catchError((error) {
        if (error is DioError) {
          emit(NewsGetSciencErrorState(
              error: DioException.dioExceptionHandling(
                  exceptionType: error.type, response: error.response)
                  ));
        }
      });
    }
  }

  List<dynamic> health = [];
  void gethealth(String country) {
    emit(NewsGetLoadingHealtState());
    if (translator.activeLanguageCode == 'ar') {
      country = 'eg';
    } else {
      country = 'us';
    }
    if (health.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": country,
        "category": 'health',
        "apiKey": key,
      }).then((value) {
        health = value.data['articles'];

        emit(NewsGetHealthDataState());
      }).catchError((error) {
        if (error is DioError) {
          emit(NewsGetHealthErrorState(
              error: DioException.dioExceptionHandling(
                  exceptionType: error.type, response: error.response)
                  ));
        }
      });
    }
  }

  List<dynamic> entertainment = [];
  void getEntertainment(String country) {
    emit(NewsGetEnterainmentState());
    if (translator.activeLanguageCode == 'ar') {
      country = 'eg';
    } else {
      country = 'us';
    }
    if (entertainment.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": country,
        "category": 'entertainment',
        "apiKey": key,
      }).then((value) {
        entertainment = value.data['articles'];

        emit(NewsGetEnterainmentState());
      }).catchError((error) {
        if (error is DioError) {
          emit(NewsGetEnterainmentErrorState(
              error: DioException.dioExceptionHandling(
                  exceptionType: error.type, response: error.response)
                  ));
        }
      });
    }
  }

  List<dynamic> technology = [];
  void getTechnology(String country) {
    emit(NewsGetLoadingTechnologytState());
    if (translator.activeLanguageCode == 'ar') {
      country = 'eg';
    } else {
      country = 'us';
    }
    if (technology.length == 0) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        "country": country,
        "category": 'technology',
        "apiKey": key,
      }).then((value) {
        technology = value.data['articles'];
        // print(science[0]['title']);
        emit(NewsGetentTechnologyDataState());
      }).catchError((error) {
        if (error is DioError) {
          emit(NewsGetentTechnologyDataState(
              error: DioException.dioExceptionHandling(
                  exceptionType: error.type, response: error.response)
                  ));
        }
      });
    }
  }

  List<dynamic> sreach = [];

  void getSreach(String value) {
    emit(NewsGetLoadingsreachState());

    DioHelper.getData(url: 'v2/everything', query: {
      "q": "$value",
      "apiKey": key,
    }).then((value) {
      
      sreach = value.data['articles'];
      emit(NewsGetsreachDataState());
    }).catchError((error) {
      if (error is DioError) {
        emit(NewsGetsreachErrorState(
            error: DioException.dioExceptionHandling(
                exceptionType: error.type, response: error.response)));
      }
    });
  }
}
