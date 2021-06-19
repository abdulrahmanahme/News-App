abstract class NewsStates {}

class IntialStates extends NewsStates {}

class BottomBarIndexState extends NewsStates {}

class ChangeAppModeState extends NewsStates {}

class GetBusinessDataState extends NewsStates {}

class NewsLoadingBusinessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState({this.error});
}

class GetSportsDataState extends NewsStates {}

class NewsLoadingSportsState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState({this.error});
}

class NewsGetScienceDataState extends NewsStates {}

class NewsGetLoadingSciencState extends NewsStates {}

class NewsGetSciencErrorState extends NewsStates {
  final String error;

  NewsGetSciencErrorState({this.error});
}

class NewsGetsreachDataState extends NewsStates {}

class NewsGetLoadingsreachState extends NewsStates {}

class NewsGetsreachErrorState extends NewsStates {
  final String error;

  NewsGetsreachErrorState({this.error});
}
