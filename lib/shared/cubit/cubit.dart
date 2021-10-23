import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'
    ),
  ];

  List<Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];


  void changeBottomNavBar(int index){
    currentIndex=index;
    emit(NewsBottomNavState());
  }

  void getBusiness () {

    emit(NewsLoadingState());

    DioHelper.getData(
        'v2/top-headlines',
        {
          'country': 'eg',
          'category': 'business',
          'apiKey': 'ba3dde471bad4c1fa3cf047f0d6be786',
        }
    ).then((value) {
      business = value.data['articles'];
      emit(GetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetBusinessErrorState(error.toString()));
    });
  }

  void getSports () {

    emit(NewsLoadingState());

    DioHelper.getData(
        'v2/top-headlines',
        {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'ba3dde471bad4c1fa3cf047f0d6be786',
        }
    ).then((value) {
      sports = value.data['articles'];
      emit(GetSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSportsErrorState(error.toString()));
    });
  }

  void getScience () {

    emit(NewsLoadingState());

    DioHelper.getData(
        'v2/top-headlines',
        {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'ba3dde471bad4c1fa3cf047f0d6be786',
        }
    ).then((value) {
      science = value.data['articles'];
      emit(GetScienceSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetScienceErrorState(error.toString()));
    });
  }

  void getSearch (String value) {
    emit(NewsLoadingState());
    DioHelper.getData(
        'v2/everything',
        {
          'q': '$value',
          'apiKey': 'ba3dde471bad4c1fa3cf047f0d6be786',
        }
    ).then((value) {
      search = value.data['articles'];
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if(fromShared != null){
      isDark = fromShared ;
      emit(ChangeAppModeState());
    }else {
      isDark = !isDark;
      CacheHelper.putData('isDark', isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }


}