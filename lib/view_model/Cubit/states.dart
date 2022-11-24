import 'package:news/view_model/server/remote/network_exceptions/network_exceptions.dart';

abstract class NewsStates {}

class IntialStates extends NewsStates {}

class BottomBarIndexState extends NewsStates {}

class ChangeAppModeState extends NewsStates {}

class ChangedTODarkState extends NewsStates {}

///////////get tobHeadline

class GetHeadlineDataState extends NewsStates {}

class NewsLoadingHeadlineState extends NewsStates {}

class NewsGetHeadlineErrorState extends NewsStates {
  ErrorResult error;

  NewsGetHeadlineErrorState({this.error});
}
///////////get Business

class GetBusinessDataState extends NewsStates {}

class NewsLoadingBusinessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  ErrorResult error;

  NewsGetBusinessErrorState({this.error});
}

class GetSportsDataState extends NewsStates {}

class NewsLoadingSportsState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  // final String error;
  final ErrorResult error;

  NewsGetSportsErrorState({this.error});
}

///////////get Science

class NewsGetScienceDataState extends NewsStates {}

class NewsGetLoadingSciencState extends NewsStates {}

class NewsGetSciencErrorState extends NewsStates {
  ErrorResult error;

  NewsGetSciencErrorState({this.error});
}

///////////get srearch

class NewsGetsreachDataState extends NewsStates {}

class NewsGetLoadingsreachState extends NewsStates {}

class NewsGetsreachErrorState extends NewsStates {
  ErrorResult error;

  NewsGetsreachErrorState({this.error});
}
///////////get health

class NewsGetHealthDataState extends NewsStates {}

class NewsGetLoadingHealtState extends NewsStates {}

class NewsGetHealthErrorState extends NewsStates {
  // final ErrorResult error;
  ErrorResult error;

  NewsGetHealthErrorState({this.error});
}

///////////entertainment

class NewsGetEnterainmentState extends NewsStates {}

class NewsGetLoadingEnterainmentState extends NewsStates {}

class NewsGetEnterainmentErrorState extends NewsStates {
  ErrorResult error;

  NewsGetEnterainmentErrorState({this.error});
}

///////////Technology

class NewsGetentTechnologyDataState extends NewsStates {
  ErrorResult error;
  NewsGetentTechnologyDataState({this.error});
}

class NewsGetLoadingTechnologytState extends NewsStates {}

class NewsGetentTechnologyErrorState extends NewsStates {
  ErrorResult error;

  NewsGetentTechnologyErrorState({this.error});
}

class CarouselSliderIndex extends NewsStates {}
