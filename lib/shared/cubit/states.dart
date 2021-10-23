abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class GetBusinessSuccessState extends NewsStates{}

class GetBusinessErrorState extends NewsStates{
  final String error;

  GetBusinessErrorState(this.error);
}

class GetSportsSuccessState extends NewsStates{}

class GetSportsErrorState extends NewsStates{
  final String error;

  GetSportsErrorState(this.error);
}

class GetScienceSuccessState extends NewsStates{}

class GetScienceErrorState extends NewsStates{
  final String error;

  GetScienceErrorState(this.error);
}

class GetSearchSuccessState extends NewsStates{}

class GetSearchErrorState extends NewsStates{
  final String error;

  GetSearchErrorState(this.error);

}

class ChangeAppModeState extends NewsStates {}
